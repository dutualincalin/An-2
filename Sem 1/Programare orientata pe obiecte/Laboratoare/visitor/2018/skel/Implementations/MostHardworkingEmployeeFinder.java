package com.oop_pub.visitor.Implementations;

import com.oop_pub.visitor.Visitor;

/**
 * Clasa folosita pentru a vedea daca media numarului de ore suplimentare pentru angajati
 * este mai mare decat cea a managerilor.
 */
public class MostHardworkingEmployeeFinder implements Visitor {

    @Override
    public void visit(Employee employee) {
        //TODO
    }

    @Override
    public void visit(Manager manager) {
        //TODO
    }

    public boolean isManagerHardWorking() {
        //TODO

        return false;
    }
}