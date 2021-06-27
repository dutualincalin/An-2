package storage;

import Observers.Observer;

import java.util.ArrayList;

public abstract class Observable{
    public ArrayList<Observer> observator = new ArrayList<>();

    public void addObservator(Observer observator){
        this.observator.add(observator);
    }
}
