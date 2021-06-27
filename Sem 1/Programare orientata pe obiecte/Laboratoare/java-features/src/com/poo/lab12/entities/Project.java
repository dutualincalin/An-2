package com.poo.lab12.entities;

public class Project {
    
    private final String name;
    private final int workers;

    public Project(String name, int workers) {
        this.name = name;
        this.workers = workers;
    }

    public String getName() {
        return name;
    }

    public int getWorkers() {
        return workers;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + workers;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Project other = (Project) obj;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (workers != other.workers)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Project [name=" + name + ", workers=" + workers + "]";
    }
    
}
