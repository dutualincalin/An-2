package main;

import Observers.ConsoleLogger;
import Observers.DataAggregator;
import communication.ServerCommunicationController;

public class Print {
    private final ConsoleLogger console;
    private final ServerCommunicationController server;
    private final DataAggregator aggregator;

    public Print(ConsoleLogger console, ServerCommunicationController server, DataAggregator aggregator){
        this.console = console;
        this.server = server;
        this.aggregator = aggregator;
    }

    @Override
    public String toString() {
        return (console.getConsoleMessage() + "\n" + server.getServerCommunicationControllerMessage()
                + "\n" + aggregator.getAggregation() + "\n");
    }
}
