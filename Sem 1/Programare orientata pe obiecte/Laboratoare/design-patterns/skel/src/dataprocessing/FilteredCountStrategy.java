package dataprocessing;

import storage.DataRepository;
import storage.SensorData;

import java.util.concurrent.TimeUnit;

public class FilteredCountStrategy implements StepCountStrategy {
    private final DataRepository database;

    public FilteredCountStrategy(DataRepository database){
        this.database = database;
    }

    @Override
    public int getTotalSteps() {
        long total = 0;
        for(SensorData numbers : database.getData()){
            if(numbers.getStepsCount() > 0)
                if(numbers.getStepsCount() <= 1000
                        || numbers.getTimestamp() >= TimeUnit.SECONDS.toMillis(60)){
                    total += numbers.getStepsCount();
                }
        }

        return (int) total;
    }

    @Override
    public String getStrategyDescription() {
        return ("This strategy sums up all the step data but filtering outliers with two conditions:\n" +
                "* step count value should be a positive number\n"
                + "* ignore values that are too big in a too short interval (more than 1000 steps in "
                +"less than 1 minute)");
    }
}
