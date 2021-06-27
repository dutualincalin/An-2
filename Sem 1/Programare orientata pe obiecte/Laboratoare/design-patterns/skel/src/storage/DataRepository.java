package storage;


import Observers.Observer;

import java.util.ArrayList;

/**
 * Persists sensor data. Observable, its observers are notified when data is added it to.
 */
public class DataRepository extends Observable { // TODO make this an Observable
    private final ArrayList<SensorData> data = new ArrayList<>();

    public void addData(SensorData dataRecord){
        data.add(dataRecord);
        for (Observer observator : observator){
            observator.update(dataRecord);
        }
    }

    public ArrayList<SensorData> getData(){
        return data;
    }
}


