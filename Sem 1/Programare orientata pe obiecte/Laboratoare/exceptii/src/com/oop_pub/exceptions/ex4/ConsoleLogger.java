package com.oop_pub.exceptions.ex4;

import java.util.EnumSet;

public class ConsoleLogger extends LoggerBase{
    public ConsoleLogger(EnumSet<LogLevel> levels) {
        super(levels);
    }

    @Override
    protected void writeMessage(String message) {
        System.out.println(LogLevel.all() + "\n[Console] " + message);
    }
}
