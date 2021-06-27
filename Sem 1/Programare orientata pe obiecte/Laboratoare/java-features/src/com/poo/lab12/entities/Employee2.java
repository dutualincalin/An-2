package com.poo.lab12.entities;

public class Employee2 extends Employee{
    public Employee2(String name, Integer age, String city) {
        super(name, age, city);
    }

    public Employee2(String name, Integer age, String city, Gender gender,
                     Disability disability, Religion religion) {
        super(name, age, city, gender, disability, religion);
    }

    public Employee2() {
    }

    @Override
    public int compareTo(Employee o) {
        if(getCity().compareTo(o.getCity()) < 0){
            return -1;
        }

        if(getCity().compareTo(o.getCity()) > 0){
            return 1;
        }

        if(getAge() < o.getAge()){
            return -1;
        }

        if(getAge() > o.getAge()){
            return 1;
        }

        return 0;
    }
}
