package com.poo.lab12.reports;

import com.poo.lab12.entities.Business;
import com.poo.lab12.entities.Disability;
import com.poo.lab12.entities.Employee;
import com.poo.lab12.entities.Employee2;
import com.poo.lab12.entities.Gender;
import com.poo.lab12.entities.Project;
import com.poo.lab12.entities.Religion;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

public class BusinessReport {

    public static Map<Disability, List<Employee>> getEmployeesOnSameDisability(Business business) {
        Map<Disability, List<Employee>> result = new HashMap<>();
        business.getEmployees().forEach(employee ->{
            if(!result.containsKey(employee.getDisability())){
                result.put(employee.getDisability(), new LinkedList<>());
            }
            result.get(employee.getDisability()).add(employee);
        });

        return result;
    }

    public static long getNumberOfDifferentProjectsWorkedByCurrentFemaleEmployees(Business business) {
        // Get employees, filter by gender, get their projects without duplicates, count
        Set<Employee> employees = business.getEmployees();
        Set<Employee> females = new TreeSet<>(employees);
        females.removeIf(person -> person.getGender() == Gender.MALE);
        Set<Project> projects = new HashSet<>();

        females.forEach(female -> projects.addAll(female.getProjects()));
        return projects.size();
    }

    public static SortedSet<Employee2> getEmployeesMaxByReligionMinByGenderSortedByCitySortedByAge(Business business) {
        // Get the employees with majority by religion, from this group select the subgroup that has the minority by gender
        // Sort the set by city and, in case of equality, by age
        final int[] buddhism = {0};
        final int[] christianity = { 0 };
        final int[] calvinism = { 0 };
        final int[] daoism = { 0 };
        final int[] hinduism = { 0 };
        final int[] islam = { 0 };
        final int[] female = { 0 };
        final int[] male = { 0 };
        final int[] max = {-1};
        SortedSet<Employee2> employees = new TreeSet<>();

        for(Employee employee : business.getEmployees()){
            employees.add(new Employee2(employee.getName(), employee.getAge(), employee.getCity(),
                    employee.getGender(), employee.getDisability(), employee.getReligion()));
        }

        final Religion[] religion = new Religion[1];
        final Gender[] gender = new Gender[1];

        business.getEmployees().forEach(employee -> {
            if(employee.getReligion() == Religion.CRISTIANITY){
                christianity[0]++;
                if(max[0] < christianity[0]){
                    max[0] = christianity[0];
                    religion[0] = Religion.CRISTIANITY;
                }
            }

            else if(employee.getReligion() == Religion.BUDDHISM){
                buddhism[0]++;
                if(max[0] < buddhism[0]){
                    max[0] = buddhism[0];
                    religion[0] = Religion.BUDDHISM;
                }
            }

            else if(employee.getReligion() == Religion.CALVINISM){
                calvinism[0]++;
                if(max[0] < calvinism[0]){
                    max[0] = calvinism[0];
                    religion[0] = Religion.CALVINISM;
                }
            }

            else if(employee.getReligion() == Religion.DAOISM){
                daoism[0]++;
                if(max[0] < daoism[0]){
                    max[0] = daoism[0];
                    religion[0] = Religion.DAOISM;
                }
            }

            else if(employee.getReligion() == Religion.HINDUISM){
                hinduism[0]++;
                if(max[0] < hinduism[0]){
                    max[0] = hinduism[0];
                    religion[0] = Religion.HINDUISM;
                }
            }

            else{
                islam[0]++;
                if(max[0] < islam[0]){
                    max[0] = islam[0];
                    religion[0] = Religion.ISLAM;
                }
            }
        });

        employees.removeIf(employee -> employee.getReligion() != religion[0]);

        max[0] = -1;

        employees.forEach(employee -> {
            if(employee.getGender() == Gender.MALE){
                male[0] ++;
                if(max[0] < male[0]){
                    max[0] = male[0];
                    gender[0] = Gender.MALE;
                }
            }

            else{
                female[0] ++;
                if(max[0] < female[0]){
                    max[0] = female[0];
                    gender[0] = Gender.FEMALE;
                }
            }
        });

        employees.removeIf(employee -> employee.getGender() == gender[0]);

        return employees;
    }

    public static Religion getReligionOfEmployeesWithMostAccounts(Business business) {
        // Group employees by religion, count the accounts in each group, return the religion with biggest score

        return null;
    }

    public static Map<Religion, Map<Gender, List<Employee>>> getEmployeesOnSameReligionAndGender(Business business) {
        // Map the employees by religion (Map<Religion, List<Employee>>) then map each of the lists by city (Map<String, List<Employee>>)
        // Hint: use Collectors.groupingBy(Function, Collector)

        return null;
    }

    public static Map<Project, Map<String, List<Employee>>> getEmployeesOnSameProjectAndCity(Business business) {
        // Map the employees to the business projects (not to their respective projects)

        return null;
    }
}
