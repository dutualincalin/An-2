package dataprocessing;

import storage.DataRepository;
import storage.SensorData;

public class BasicCountStrategy implements StepCountStrategy {
    private final DataRepository database;

    public BasicCountStrategy(DataRepository database){
        this.database = database;
    }

    @Override
    public int getTotalSteps() {
        long total = 0;
        for(SensorData numbers : database.getData()){
            total += numbers.getStepsCount();
        }

        return (int) total;
    }

    @Override
    public String getStrategyDescription() {
        return ("This strategy sums up all the step data received so far");
    }
}
