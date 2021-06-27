package com.poo.lab12.entities;

import java.util.*;

import com.poo.lab12.exceptions.ExistsException;

public class Business {
    
    private final Set<Employee> employees = new HashSet<>();
    private final List<Project> projects = new ArrayList<>();

    public void addEmployee(final Employee employee) throws ExistsException {
    	if (employees.contains(employee)) {
    		throw new ExistsException("Employee already exists into the business.");
    	} 
    		
    	employees.add(employee);
    }

    public void addProject(final Project project) throws ExistsException {
    	if (projects.contains(project)) {
    		throw new ExistsException("Project already exists into the business.");
    	} 
    		
    	projects.add(project);
    }
    
    public Set<Employee> getEmployees() {
		return Collections.unmodifiableSet(employees);
    }
    
    public List<Project> getProjects() {
		return Collections.unmodifiableList(projects);
    }

}
