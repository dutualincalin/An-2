package com.poo.lab12.reports;

import com.poo.lab12.entities.Account;
import com.poo.lab12.entities.Bank;
import com.poo.lab12.entities.Employee;
import com.poo.lab12.entities.Gender;
import com.poo.lab12.entities.Project;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.SortedSet;
import java.util.TreeSet;

public class BankReport {
    // Customer = Employee of the Business
    // Business = a client of the Bank
    // Customers of the Bank = all the Employees that work for the Businesses that are clients of the Bank

    public static int getNumberOfCustomers(Bank bank) {
        // All the customers that have accounts at the bank

        return bank.getClients().stream().mapToInt
                (business -> business.getEmployees().size()).sum();

    }

    public static int getNumberOfAccounts(Bank bank) {
        // Accounts of all the customers of the bank
        final int[] accountsNumber = {0};

        bank.getClients().forEach(business -> business.getEmployees().forEach
                (employees -> accountsNumber[0] += employees.getAccounts().size()));

        return (int)accountsNumber[0];
    }

    public static SortedSet<Employee> getCustomersSorted(Bank bank) {
        // Display the set of customers in alphabetical order
        SortedSet<Employee> result = new TreeSet<>();

        bank.getClients().forEach(business -> result.addAll(business.getEmployees()));

        return result;
    }

    public static double getTotalSumInAccounts(Bank bank) {
        // Sum of all customers' accounts balances
        final int[] accountsBalance = {0};

        bank.getClients().forEach(business -> business.getEmployees().forEach
                (employee -> employee.getAccounts().forEach(account -> accountsBalance[0]
                        += account.getBalance())));

        return accountsBalance[0];
    }

    public static SortedSet<Account> getAccountsSortedBySum(Bank bank) {
        // The set of all accounts, ordered by current account balance
        SortedSet<Account> result = new TreeSet<>();

        bank.getClients().forEach(business -> business.getEmployees()
                        .forEach(client -> result.addAll(client.getAccounts())));

        return result;
    }

    public static Map<Employee, Collection<Account>> getCustomerAccounts(Bank bank) {
        // Return a map of all the customers with their respective accounts
        Map<Employee, Collection<Account>> result = new HashMap<>();

        bank.getClients().forEach(business -> business.getEmployees()
                .forEach(client -> result.put(client, client.getAccounts())));

        return result;
    }

    public static Map<String, List<Employee>> getCustomersByCity(Bank bank) {
        // Map all the customers to their respective cities
        Map<String, List<Employee>> result = new HashMap<>();

        bank.getClients().forEach(business -> business.getEmployees()
                .forEach(client -> result.put(client.getCity(), new ArrayList<>())));

        bank.getClients().forEach(business -> business.getEmployees()
                .forEach(client -> result.get(client.getCity()).add(client)));

        return result;
    }

    public static Project getProjectWorkedOnByMostCustomers(Bank bank) {
        // Get all the projects from the employees and find the most repeated one in the list
        HashMap<Project, Integer> frequency = new HashMap<>();

        bank.getClients().forEach(business -> business.getEmployees()
                .forEach(employee -> employee.getProjects().forEach(project -> {
                    if (!frequency.containsKey(project)) {
                        frequency.put(project, 0);
                    } else {
                        frequency.put(project, frequency.get(project) + 1);
                    }
                })));

        Map.Entry<Project, Integer> maxEntry = null;

        for(Map.Entry<Project, Integer> entry : frequency.entrySet()){
            if(maxEntry == null || entry.getValue().compareTo(maxEntry.getValue()) > 0) {
                maxEntry = entry;
            }
        }

        return Objects.requireNonNull(maxEntry).getKey();
    }

    public static Gender getGenderWhoWorkedOnMostProjects(Bank bank) {
        // Get all the pairs <gender, project> or <gender, List<project>>, then reduce the array to only one pair
        // of each gender and retrieve the one with most counted projects (you are expected to count duplicates as well).

        Gender male = Gender.MALE;
        Gender female = Gender.FEMALE;
        final int[] maleCount = {0};
        final int[] femaleCount = {0};

        bank.getClients().forEach(business -> business.getEmployees()
                .forEach(employee -> {
                    if(employee.getGender() == male){
                        maleCount[0] += employee.getProjects().size();
                    }

                    else femaleCount[0] += employee.getProjects().size();
                }));

        if(maleCount[0] > femaleCount[0])
            return male;

        else return female;
    }
}
