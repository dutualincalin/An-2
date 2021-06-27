package com.oop_pub.visitor;

public class Examples {

    public static void main(String[] args) {
        System.out.println("\nInitialization:\n");

        A a = new A("hi");
        System.out.println();

        A a2 = new B("hi");
        System.out.println();

        B b = new C("hi");
        System.out.println();

        B b2 = new B("hi");
        System.out.println();

        //C c = new C(); //compiler error
        C c = new C("hi");
        System.out.println();

        System.out.println("\nOverrding:\n");
        a.f(1);
        a2.f(2);
        b.f(3);
        b2.f(4);
        b.g("a", "b");
        //a.f("a", "b"); //compiler error
        //b.f();//compiler error
        
        System.out.println("\nOverloading:\n");

        new Examples().test(a);
        new Examples().test(a2);
        new Examples().test(b);
        new Examples().test(b2);
        new Examples().test(c);
    }
    
    private void test(A a) {
        System.out.println("Testing A");
        a.f(10);
    }
    
    private void test(B b) {
        System.out.println("Testing B");
        b.f(10);
    }
    
    private void test(C c) {
        System.out.println("Testing C");
        c.f(10);
    }
}

class A {

    A(){

    }

    A(String s) {
        System.out.println("Constructor A, s = " + s + " this = " + this);
    }

    public void f(int x) {
        System.out.println("In A, x = " + x + " this = " + this);
    }
  
}

class B extends A{

    B(){

    }
    
    B(String s) {
        super(s);

        System.out.println("Constructor B, s = " + s + " this = " + this);
    }

    public void f(int x) {
        System.out.println("In B, x = " + x + " this = " + this);
    }

    /* versiunea gresita de pus in schelet
    void f(int x) {
        System.out.println("In B, x = " + x + " this = " + this);
    }
    */
    
    public void f(int x, int y) {
        System.out.println("In B, x = " + x + " y = " + y + " this = " + this);
    }

    public void g(String s) {
        System.out.println("In B, s = " + s + " this = " + this);
    }

    void g(String s, String t) {
        System.out.println("In B, s = " + s + " t = " + t + " this = " + this);

    }

    /* versiunea gresita de pus in schelet
    public int g(String s) {
        System.out.println("In B, s = " + s + " this = " + this);
        return 0;
    }
    */
  
}

class C extends B {
   
    /* versiunea gresita de pus in schelet
    C (String s) {
        System.out.println("Constructor C, s = " + s + " this = " + this);
    }
    */
    
    C (String s) {
        super(s);

        System.out.println("Constructor C, s = " + s + " this = " + this);
    }

    public void f() {
        super.f(1);
    } 
}
