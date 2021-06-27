package com.oop_pub.exceptions.ex4;

import java.util.EnumSet;

public class EmailLogger extends LoggerBase{

    public EmailLogger(EnumSet<LogLevel> levels) {
        super(levels);
    }

    @Override
    protected void writeMessage(String message) {
        System.out.println("[" + LogLevel.FunctionalMessage + ", " + LogLevel.FunctionalError +
                "]\n[Email] " + message);
    }
}
