package com.oop_pub.exceptions.ex4;

import java.util.EnumSet;

public abstract class LoggerBase {
    LoggerBase nextLogger;
    EnumSet<LogLevel> levels;
    String message;

    public LoggerBase(EnumSet<LogLevel> levels){
        this.levels = levels;
    }

    public void setNext(LoggerBase logger){
        nextLogger = logger;
    }

    protected abstract void writeMessage(String message);

    public void message(String message, LogLevel severity){
        if(levels.contains(severity)){
            writeMessage(message);
        }

        if(null != nextLogger) {
            nextLogger.message(message, severity);
        }
    }
}