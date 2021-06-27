package com.oop_pub.visitor.Implementations;

import com.oop_pub.visitor.Visitable;
import com.oop_pub.visitor.Visitor;

public class Employee implements Visitable {
    protected String name;
    protected float salary;
    protected float extraHours;

    public Employee(String name, float salary) {
        this.name = name;
        this.salary = salary;
    }

    public Employee(String name, float salary, float extraHours) {
        this.name = name;
        this.salary = salary;
        this.extraHours = extraHours;
    }

    public String getName() {
        return name;
    }

    public float getSalary() {
        return salary;
    }

    public float getExtraHours() {
        return extraHours;
    }

    public void setExtraHours(int extraHours) {
        this.extraHours = extraHours;
    }

    @Override
    public void accept(Visitor v) {
        v.visit(this);
    }
}
