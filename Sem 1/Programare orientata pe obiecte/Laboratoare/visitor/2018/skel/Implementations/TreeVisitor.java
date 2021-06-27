package com.oop_pub.visitor.Implementations;


import com.oop_pub.visitor.Visitable;
import com.oop_pub.visitor.Visitor;

/**
 * Clasa folosita pentru a parcurge o structura ierarhica / arborescenta - separa doua
 * concepte: un obiect de tipul visitor ce realizeaza operatii pe un set de date
 * (ex. calculeaza media orelor suplimentare) si acest tip de visitor (TreeVisitor)
 * ce parcurge nodurile structurii arborescente si aplica visitor-ul ce realizeaza operatii
 * (prezentat anterior).
 */
public class TreeVisitor implements Visitor {

    private Visitor baseVisitor;

    public TreeVisitor(Visitor baseVisitor) {
        this.baseVisitor = baseVisitor;
    }

    @Override
    public void visit(Employee employee) {
        //TODO
    }

    @Override
    public void visit(Manager manager) {
        //TODO
    }

    public Visitor getBaseVisitor() {
        return baseVisitor;
    }
}