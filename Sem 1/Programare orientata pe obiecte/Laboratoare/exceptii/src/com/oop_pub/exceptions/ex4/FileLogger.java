package com.oop_pub.exceptions.ex4;

import java.util.EnumSet;

public class FileLogger extends LoggerBase{
    public FileLogger(EnumSet<LogLevel> levels) {
        super(levels);
    }

    @Override
    protected void writeMessage(String message) {
        System.out.println("["  + LogLevel.Warning + ", " + LogLevel.Error + "]\n[File] " + message);
    }
}
