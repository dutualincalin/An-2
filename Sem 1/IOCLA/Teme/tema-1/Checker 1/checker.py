#!/usr/bin/env python3

import ctypes
import os
import re
import sys
import difflib

NUM_TESTS = 16
PASS_TESTS = 0

OUT_DIR = 'output'

def string_escape(s, encoding='utf-8'):
    return  (
        s
        .encode('latin1')
        .decode('unicode-escape')
        .encode('latin1')
        .decode(encoding)
    )

def main():
    diff = difflib.Differ()
    iocla_printf = ctypes.CDLL('./libprint.so').iocla_printf
    libc = ctypes.CDLL('libc.so.6')
    data_type_regex = re.compile('%?%[duxcs]')
    c_data_type = {
        '%d': lambda x: ctypes.c_int32(int(x)),
        '%u': lambda x: ctypes.c_uint32(int(x)),
        '%x': lambda x: ctypes.c_uint32(int(x)),
        '%c': lambda x: ctypes.c_wchar(string_escape(x)),
        '%s': lambda x: str.encode(string_escape(x))
    }

    if not os.path.exists(OUT_DIR):
        os.makedirs(OUT_DIR)

    print(25 * '=' + ' Tema 1 IOCLA ' + '=' * 25 + '\n') # Total = 64

    for test_no in range(NUM_TESTS):
        with open(f'input/test{test_no}') as test:
            description, *print_params = test.read().split('\n')
            fmt, *args = print_params
            for idx, identifier in enumerate(re.findall(data_type_regex, fmt)):
                if identifier.startswith('%%'):
                    continue
                args[idx] = c_data_type[identifier](args[idx])
            fmt = str.encode(string_escape(fmt))

            sys_stdout = os.dup(sys.stdout.fileno())

            iocla_fd = os.open(f'{OUT_DIR}/test{test_no}.out', os.O_WRONLY | os.O_CREAT | os.O_TRUNC)
            os.dup2(iocla_fd, sys.stdout.fileno())
            iocla_printf_ret = iocla_printf(fmt, *args)
            libc.fflush(None)
            os.close(iocla_fd)

            libc_fd = os.open(f'{OUT_DIR}/test{test_no}.ref', os.O_WRONLY | os.O_CREAT | os.O_TRUNC)
            os.dup2(libc_fd, sys.stdout.fileno())
            libc_printf_ret = libc.printf(fmt, *args)
            libc.fflush(None)
            os.close(libc_fd)

            os.dup2(sys_stdout, sys.stdout.fileno())

            iocla_out = open(f'{OUT_DIR}/test{test_no}.out', 'r').read()
            libc_out = open(f'{OUT_DIR}/test{test_no}.ref', 'r').read()
            diff = list(difflib.unified_diff(iocla_out, libc_out))

            print(f'{test_no} {description} ' + (55 -len(description) - test_no // 10) * '.', end=' ')
            if len(diff) == 0:
                if iocla_printf_ret != libc_printf_ret:
                    print(' FAIL')
                    print(f'Your print returned {iocla_printf_ret} instead of {libc_printf_ret}')
                else:
                    print(' PASS')
                    global PASS_TESTS
                    PASS_TESTS = PASS_TESTS + 1
            else:
                print(' FAIL')
                # print('\n'.join(diff))

            os.close(sys_stdout)

    print(f'\nTotal: {PASS_TESTS / NUM_TESTS * 100:.2f}')

if __name__ == '__main__':
    main()
