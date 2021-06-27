package com.oop_pub.visitor;

import com.oop_pub.visitor.Implementations.Boss;
import com.oop_pub.visitor.Implementations.Employee;
import com.oop_pub.visitor.Implementations.Intern;

public interface Visitor {
    void visit(Employee employee);

    void visit(Manager manager);
}
