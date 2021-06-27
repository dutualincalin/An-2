package Observers;

import storage.SensorData;

public class ConsoleLogger implements Observer {
    private SensorData dataRecord;
    private int stepchange = 0;
    private int timestamp  = 0;

    public ConsoleLogger(){
        dataRecord = new SensorData(0,0);
    }

    @Override
    public void update(SensorData data) {
        if(dataRecord.getStepsCount() != data.getStepsCount())
            stepchange = 1;

        if(dataRecord.getTimestamp() != data.getTimestamp())
            timestamp = 1;

        dataRecord = data;
    }

    public String getConsoleMessage(){
        if(stepchange == 1 && timestamp == 1)
            return ("Console: Data record was successfully introduced in database: " + dataRecord);

        else return("Console: No data record added");
    }
}
