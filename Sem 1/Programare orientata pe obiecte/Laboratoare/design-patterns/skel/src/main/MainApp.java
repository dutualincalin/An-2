package main;

import Observers.ConsoleLogger;
import Observers.DataAggregator;
import communication.ServerCommunicationController;
import storage.DataRepository;
import storage.SensorData;
import java.util.Scanner;

public class MainApp {

    public static void main(String[] args) {

        System.out.println("Choose a strategy: type 'basic or 'filtered");
        Scanner scanner = new Scanner(System.in);
        String strategyType = scanner.next();
        scanner.close();

        DataRepository dataRepository = new DataRepository();
        ConsoleLogger console = new ConsoleLogger();
        ServerCommunicationController server = new ServerCommunicationController();
        DataAggregator aggregator = new DataAggregator(strategyType, dataRepository);
        Print print = new Print(console, server, aggregator);
        // TODO: use the StepCountStrategyFactory to create a strategy

        // TODO: add observers to the dataRepository
            dataRepository.addObservator(console);
            dataRepository.addObservator(server);
            dataRepository.addObservator(aggregator);

        // TODO: uncomment
        long baseTimestamp = System.currentTimeMillis();

        dataRepository.addData(new SensorData(10, baseTimestamp + 1));
        System.out.println(print);

        dataRepository.addData(new SensorData(20, baseTimestamp + 2));
        System.out.println(print);

        dataRepository.addData(new SensorData(30, baseTimestamp + 3));
        System.out.println(print);

        // TODO: after the first successful run, change this to baseTimestamp + 40000 and check the result
        dataRepository.addData(new SensorData(4000, baseTimestamp + 4000));
        System.out.println(print);

        dataRepository.addData(new SensorData(50, baseTimestamp + 5));
        System.out.println(print);

        dataRepository.addData(new SensorData(-100, baseTimestamp + 6));
        System.out.println(print);

        dataRepository.addData(new SensorData(1001, 59999));
        System.out.println(print);

        dataRepository.addData(new SensorData(500, baseTimestamp + 600));
        System.out.println(print);
    }
}
