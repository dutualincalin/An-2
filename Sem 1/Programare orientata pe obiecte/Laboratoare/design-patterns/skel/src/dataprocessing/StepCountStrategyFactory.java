package dataprocessing;

import storage.DataRepository;

public class StepCountStrategyFactory {
    public StepCountStrategy createStrategy(String strategyType, DataRepository dataRepository){
        StepCountStrategy strategy;

        if(strategyType.equals("basic"))
            strategy = new BasicCountStrategy(dataRepository);

        else strategy = new FilteredCountStrategy(dataRepository);

        return strategy;
    }
}
