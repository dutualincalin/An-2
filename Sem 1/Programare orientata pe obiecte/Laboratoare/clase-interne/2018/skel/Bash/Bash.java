package com.oop_pub.clase_interne.Bash;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Scanner;

public class Bash {
    Path currentDirectory;
    StringBuffer history;

    private CommandPublisher publisher;
    private static final String EXIT = "exit";

    public Bash() {
        // TODO 2 Initialize history and currentDirectory;
        // history = ...;
        // currentDirectory = ...;

        // TODO 2 Instantiate a new command publisher
        // publisher = ... ;

        // TODO 4 & 5 & 6 & 7
        // CommandSubscribers know how to execute the commands. Subscribe some to the Command publisher.
    }

    public void start() {
        Scanner scanner = new Scanner(System.in);

        while (true) {
            // TODO 3 Read commands from the command line
            // String input = ... ;

            // TODO 3 If we read the "exit" string then we should stop the program.

            // TODO 3 Create an anonymous class which extends Thread.
            // It has to implement the 'run' method. From the 'run' method publish the command
            // so that the CommandSubscribers start executing it.
            // Don't forget to start the thread by calling the 'start' method on it!
        }
    }

    // TODO 1: Create an inner class which implements the CommandPublisher interface.
    // 1. The class should contain an ArrayList of CommandSubscribers
    // 2. The class should implement the subscribe and publish methods.
}
