package com.oop_pub.visitor;

import com.oop_pub.visitor.Implementations.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;

public class Test {

    public static void main(String[] args) {

        System.out.println("---------- Ex. 1 ----------");
        test1();

        System.out.println("---------- Ex. 2 ----------");
        test2();

        System.out.println("---------- Ex. 3 ----------");
        test3();

        System.out.println("---------- Ex. 4 ----------");
        test4();
    }

    private static void test1() {

        List<Employee> employees = new LinkedList<Employee>();
        employees.add(new Employee("Bob", 200));
        employees.add(new Employee("Trudy", 900));
        employees.add(new Manager("Alice", 10000, 42));

        Visitor v = new RevenueVisitor();
        for (Employee e : employees)
            e.accept(v);
    }

    private static void test2() {
        /*
         * Dr
         *   - Clara
         *   - River
         *   	- Amy
         *   	- Rory
         */
        Manager ceo = new Manager("Dr", 10000, 2, 42);
        Manager manager = new Manager("River", 9000, 7, 20);

        manager.addSubordinate(new Employee("Amy", 2500, 10));
        manager.addSubordinate(new Employee("Rory", 2000, 5));

        ceo.addSubordinate(new Employee("Clara", 2200, 0));
        ceo.addSubordinate(manager);

        MostHardworkingEmployeeFinder extraHoursVisitor =
                new MostHardworkingEmployeeFinder();
        //TODO folositi MostHardworkingEmployeeFinder and TreeVisitor
        //hint: ceo este root-node pentru TreeVisitor

        System.out.format("The %s are the most hardworking\n",
                extraHoursVisitor.isManagerHardWorking() ? "managers " : "employees");

        // TODO schimbati valorile din extraHours pentru obiectele declarate si observati schimbarile
    }

    private static void test3() {
        /*
         * Dr
         *   - Clara
         *   - River
         *   	- Amy
         *   	- Rory
         *   - LowlyIntern
         */
        Manager ceo = new Manager("Dr", 10000, 2, 42);
        Manager manager = new Manager("River", 9000, 7, 20);

        manager.addSubordinate(new Employee("Amy", 2500, 10));
        manager.addSubordinate(new Employee("Rory", 2000, 5));

        ceo.addSubordinate(new Employee("Clara", 2200, 0));
        ceo.addSubordinate(manager);

        //TODO adaugati un intern
        //TODO aplicati RevenueVisitr pe subordonatii lui ceo

        MostHardworkingEmployeeFinder extraHoursVisitor =
                new MostHardworkingEmployeeFinder();
        //TODO folositi MostHardworkingEmployeeFinder and TreeVisitor
        //hint: ceo este root-node pentru TreeVisitor

        System.out.format("The %s are the most hardworking\n",
                extraHoursVisitor.isManagerHardWorking() ? "managers " : "employees");
    }

    private static void test4() {

        Path startingDir = Paths.get(".");
        FilesCounter counter = new FilesCounter();

        //TODO
        // folositi Files.walkFileTree
        // obtineti lista fisierelor, afisati-i dimensiunea si caile catre acestea
    }
}