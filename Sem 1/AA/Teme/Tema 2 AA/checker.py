#!/usr/bin/env python3

# Copyright 2020
# Author: Matei Simtinică

import os
import sys
import subprocess

LANGUAGES = ["cpp", "java"]
CPP_EXEC = "src/cpp_implementation/main"
JAVA_EXEC = "Main"

CPP_SRC_FOLDER = "src/cpp_implementation"
JAVA_SRC_FOLDER = "src/java_implementation"

RUN_COMMAND = {
    "cpp": [CPP_EXEC],
    "java": ["java", "-cp", "src/java_implementation", JAVA_EXEC]
}

MAKE_COMMAND = {
    "cpp": ["make", "-C", CPP_SRC_FOLDER],
    "java": ["make", "-C", JAVA_SRC_FOLDER]
}

IN_PREFIX = "in/"
OUT_PREFIX = "out/"
SAT_IN_PREFIX = "sat_in/"
SAT_OUT_PREFIX = "sat_out/"
REF_PREFIX = "ref/"

LOG_FILE = "checker_log.txt"
README_FILE = "README"

TASKS = ["task1", "task2", "task3", "bonus"]
SCORES = {
    "task1": [0.5] * 18 + [1] * 11 + [2] * 5,
    "task2": [0.5] * 28 + [1] * 6,
    "task3": [0.5] * 12 + [1] * 12 + [2] * 11,
    "bonus": [0.5] * 30 + [1] * 5
}
TASK_SCORES = {k: sum(v) for k, v in SCORES.items()}
README_SCORE = 10
MAX_SCORE = sum(list(TASK_SCORES.values())[:-1]) + README_SCORE


def get_tests_count(task):
    input_dir = IN_PREFIX + task
    filenames = [f for f in os.listdir(input_dir) if f.endswith(".in") and f != "custom.in"]
    return len(filenames)


def read_network(filename):
    with open(filename, "r") as file:
        variables = [int(x) for x in file.readline().split()]
        if len(variables) == 3:
            family_count, connection_count, custom_property = variables
        else:
            family_count, connection_count = variables
            custom_property = None
        network = [[] for _ in range(family_count)]
        for line in file.readlines():
            family1, family2 = [int(x) for x in line.split()]
            network[family1 - 1].append(family2 - 1)
            network[family2 - 1].append(family1 - 1)
    return network, custom_property


def verify_task1_solution(network, spies, max_spy_count):
    if len(set(spies)) > max_spy_count:
        return False

    for family, connections in enumerate(network):
        for neighbour in connections:
            if spies[family] == spies[neighbour]:
                return False
    return True


def verify_task2_solution(network, extended_family):
    for family1 in range(len(extended_family)):
        for family2 in range(family1 + 1, len(extended_family)):
            if extended_family[family1] not in network[extended_family[family2]]:
                return False
    return True


def verify_task3_solution(network, arrested):
    for family, connections in enumerate(network):
        for connection in connections:
            if family not in arrested and connection not in arrested:
                return False
    return True


def verify_task1(in_filename, out_filename, ref_filename):
    network, max_spy_count = read_network(in_filename)
    family_count = len(network)

    with open(out_filename, 'r') as file:
        ans = file.readline().strip()
        if ans == "True":
            spies = list(map(int, file.readline().split()))
            if len(spies) != family_count:
                return f"invalid number of spies: {len(spies)}"

    with open(ref_filename, 'r') as file:
        ref_ans = file.readline().strip()

    if ref_ans != ans:
        return f"output ({ans}) is different from ref ({ref_ans})"
    if ans == "True" and not verify_task1_solution(network, spies, max_spy_count):
        return "invalid spy distribution"
    return "ok"


def verify_task2(in_filename, out_filename, ref_filename):
    network, extended_family_size = read_network(in_filename)

    with open(out_filename, 'r') as file:
        ans = file.readline().strip()
        if ans == "True":
            extended_family = [int(x) - 1 for x in file.readline().split()]
            if len(extended_family) != extended_family_size:
                return "wrong number of families"

    with open(ref_filename, 'r') as file:
        ref_ans = file.readline().strip()

    if ref_ans != ans:
        return f"output ({ans}) is different from ref ({ref_ans})"
    if ans == "True" and not verify_task2_solution(network, extended_family):
        return "answer is not an extended family"
    return "ok"


def verify_task3(in_filename, out_filename, ref_filename):
    network, _ = read_network(in_filename)

    with open(ref_filename, 'r') as file:
        k = file.readline().strip()
        k = int(k)

    with open(out_filename, 'r') as file:
        arrested = [int(x) - 1 for x in file.readline().split()]
        if len(arrested) != k:
            return "wrong number of arrests"

    if not verify_task3_solution(network, arrested):
        return "some families are still connected"
    return "ok"


def verify_result(task, in_file, out_file, ref_file):
    if not os.path.isfile(out_file):
        return "no output file"
    if task == "task1":
        return verify_task1(in_file, out_file, ref_file)
    if task == "task2":
        return verify_task2(in_file, out_file, ref_file)
    if task == "task3":
        return verify_task3(in_file, out_file, ref_file)
    if task == "bonus":
        return verify_task3(in_file, out_file, ref_file)
    return None


def get_filenames(task, test):
    in_filename = os.path.join(IN_PREFIX, task, str(test).zfill(2)) + ".in"
    sat_in_filename = os.path.join(SAT_IN_PREFIX, task, str(test).zfill(2))
    if task == "bonus":
        sat_in_filename += ".wcnf"
    else:
        sat_in_filename += ".cnf"
    out_filename = os.path.join(OUT_PREFIX, task, str(test).zfill(2)) + ".out"
    sat_out_filename = os.path.join(SAT_OUT_PREFIX, task, str(test).zfill(2)) + ".sol"
    ref_file = os.path.join(REF_PREFIX, task, str(test).zfill(2)) + ".ref"
    return in_filename, sat_in_filename, out_filename, sat_out_filename, ref_file


def test_specific(language, task, test, individual_run=False):
    in_filename, sat_in_filename, out_filename, sat_out_filename, ref_file = get_filenames(task, test)
    for file in [sat_in_filename, sat_out_filename, out_filename]:
        if os.path.isfile(file):
            os.remove(file)

    args = [task, in_filename, sat_in_filename, sat_out_filename, out_filename]
    run = RUN_COMMAND[language]

    process = subprocess.run(run + args, capture_output=True)
    if process.returncode != 0 or individual_run or test == 'custom':
        if individual_run or test == 'custom':
            file = sys.stderr
        else:
            file = open(LOG_FILE, 'a')
            print(f"\n{language}; {task}; test {test}\n", file=file)
        print("stdout:", file=file)
        print(process.stdout.decode(), file=file)
        print("stderr:", file=file)
        print(process.stderr.decode(), file=file)
        if not individual_run and test != 'custom':
            print(f"{'='*40}\n", file=file)
            file.close()
            return f"main program failed, see {LOG_FILE}"
        elif process.returncode != 0:
            return "failed"

    if test == "custom":
        with open(out_filename) as file:
            print("Custom test out file:")
            for line in list(file):
                print(line)
        return None

    result = verify_result(task, in_filename, out_filename, ref_file)
    if individual_run:
        if result == "ok":
            message = "OK"
        else:
            message = f"FAILED\nError message: {result}"
        print(f"{task} test {test} result: {message}")

    return result


def test_task(language, task):
    print(f"Testing {task.capitalize()}")
    tests_count = get_tests_count(task)
    task_score = 0
    for test in range(tests_count):
        test_score = SCORES[task][test]
        result = test_specific(language, task, test)
        if result == "ok":
            message = "OK"
            score = test_score
            notes = ""
        else:
            message = "FAILED"
            score = 0
            notes = f" Error message: {result}"
        print(f"    test {str(test).rjust(2)} {'.' * 30} {message.ljust(7)}({score}/{test_score}) {notes}")
        task_score += score
    print(f"    {task.capitalize()} score: {task_score}/{TASK_SCORES[task]}")
    return task_score


def test_readme():
    message = f'README {"."*30}'
    score = 0
    if not os.path.isfile(README_FILE):
        message += "FAILED; README file not found"
    else:
        with open(README_FILE) as f:
            content = ''.join(f.readlines()).strip()
            if not content:
                message += "FAILED; README file is empty"
            else:
                message += "OK"
                score = 10
    print(message)
    print()
    return score


def test_all(language):
    total_score = 0

    print(f"\nRunning {language} implementation\n")

    for task in TASKS:
        task_score = test_task(language, task)
        total_score += task_score
        print()

    readme_score = test_readme()
    total_score += readme_score

    print(f"Total score: {total_score}/{MAX_SCORE}")


def print_usage(error_message=''):
    prev_out = sys.stdout
    sys.out = sys.stderr
    if error_message:
        print(error_message)
    print("Usage: ")
    print("  to run all tests from all tasks:  ./checker.py <language>")
    print("  to run all tests from a task:     ./checker.py <language> <task>")
    print("  to run a specific test:           ./checker.py <language> <task> <test>")
    print("  to run a custom test:             ./checker.py <language> <task> custom")
    print()
    print(f"<language> should be one of {LANGUAGES}")
    print(f"<task> should be one of {TASKS}")
    sys.stdout = prev_out


def parse_args(args):
    if len(args) not in [2, 3, 4]:
        print_usage("Invalid number of parameters")
        sys.exit(-1)

    language = args[1]

    if len(args) == 2:
        task = "all"
        test = -1
    elif len(args) == 3:
        task = args[2]
        test = -1
    else:
        task = args[2]
        test = args[3]
        if not test.isnumeric() and test != "custom":
            print_usage('Test must be a number or "custom"')
            sys.exit(-1)
        if test != "custom":
            test = int(test)
            if test >= get_tests_count(task):
                print_usage("Invalid test number")
                sys.exit(-1)

    if language == 'help':
        print_usage()
        sys.exit(0)
    elif language not in LANGUAGES:
        print_usage(f"Invalid language: {language}")
        sys.exit(-1)

    if task not in TASKS and task != "all":
        print_usage("Invalid task")
        sys.exit(-1)

    return language, task, test


def build_code(language):
    result = subprocess.run(MAKE_COMMAND[language], capture_output=True)
    out = result.stdout.decode()
    err = result.stderr.decode()

    if result.returncode != 0:
        print(f"Building failed, command: {' '.join(MAKE_COMMAND[language])}", file=sys.stderr)
        print("stdout:", file=sys.stderr)
        print(out, file=sys.stderr)
        print("stderr:", file=sys.stderr)
        print(err, file=sys.stderr)
        sys.exit(-1)


def main():
    language, task, test = parse_args(sys.argv)

    build_code(language)
    open(LOG_FILE, 'w').close()

    if test != -1:
        test_specific(language, task, test, individual_run=True)
    elif task != "all":
        test_task(language, task)
    else:
        test_all(language)


if __name__ == "__main__":
    main()
