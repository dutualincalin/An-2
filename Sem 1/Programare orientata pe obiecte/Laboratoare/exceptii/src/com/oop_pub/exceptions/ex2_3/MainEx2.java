package com.oop_pub.exceptions.ex2_3;

import java.util.ArrayList;
import java.util.List;

public class MainEx2 {
    public static void main(String[] args) {
        Calculator calculator = new Doubler();

        System.out.println(calculator.add(2d, 3d));
        System.out.println(calculator.divide(9d, 4d));
        System.out.println(calculator.average(List.of(1d, 2d, 3d, 4d)));
        System.out.println("\n-------------------------------------------\n");


        // Pentru NullParameterException

        try {
            try {
                try {
                    System.out.println(calculator.add(null, 3d));
                } catch (Calculator.NullParameterException e) {
                    System.out.println("add: Exista elemente nule.");
                }

                System.out.println(calculator.divide(null, 4d));
            } catch (Calculator.NullParameterException e) {
                System.out.println("divide: Exista elemente nule, again..");
            }

            List<Double> list = new ArrayList<>();
            list.add(1d);
            list.add(2d);
            list.add(null);
            System.out.println(calculator.average(list));
        } catch (Calculator.NullParameterException e){
            System.out.println("average: And again exista elemente nule.");
        }

        System.out.println("\n-------------------------------------------\n");


        // Pentru OverflowException

        try {
            try {
                try {
                    System.out.println(calculator.add(2d, Double.POSITIVE_INFINITY));
                } catch (Calculator.OverflowException e) {
                    System.out.println(
                            "add: Nu stiu cum ai facut, nu stiu cum ai reusit, dar rezultatul da infinit.");
                }

                System.out.println(calculator.divide(9d, Double.POSITIVE_INFINITY));
            } catch (Calculator.OverflowException e) {
                System.out.println("divide: Din nou nu stiu cum faci, dar da infinit.");
            }

            System.out.println(calculator.average(List.of(1d, Double.POSITIVE_INFINITY, 3d, 4d)));
        }
        catch (Calculator.OverflowException e){
            System.out.println("average: This is infinity result ma man, pls get some help.");
        }

        System.out.println("\n-------------------------------------------\n");


        // Fiecare instructiune de aici arunca UnderflowException

        try{
            try{
                try{
                    System.out.println(calculator.add(2d, Double.NEGATIVE_INFINITY));
                }

                catch (Calculator.UnderflowException e){
                    System.out.println("add: Now you got negative infinity?????");
                }

                System.out.println(calculator.divide(9d, Double.NEGATIVE_INFINITY));
            }
            catch (Calculator.UnderflowException e){
                System.out.println("divide: You seem to insist on that - infinity result. Please stop!");
            }

            System.out.println(calculator.average(List.of(1d, Double.NEGATIVE_INFINITY, 3d, 4d)));
        }

        catch (Calculator.UnderflowException e){
            System.out.println("average: You know what...I have no fear, but that thing (watches at - infinity result) that thing...It scares me!");
        }



        // Pentru exercitiul 3 - Alegerea fireasca (daca inteleg bine intrebarea) este pentru
        // exceptiile checked, deoarece exceptiile unchecked nu pot fi prinse, ci doar aruncate.
        // Pentru urmatoarea intrebare (daca o inteleg si pe asta ca e foarte ambigua) si
        // presupunand ca utilizatorul nu stie Java atunci raspunsul este da.
    }
}
