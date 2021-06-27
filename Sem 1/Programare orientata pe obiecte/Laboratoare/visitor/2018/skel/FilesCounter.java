package com.oop_pub.visitor;

import static java.nio.file.FileVisitResult.*;

import java.nio.file.FileVisitResult;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;

/**
 * Retine caile tuturor fisierelor Java din directorul dat.
 */
public class FilesCounter extends SimpleFileVisitor<Path> {

    private ArrayList<Path> javaFiles;

    public final ArrayList<Path> getJavaFiles() {
        return javaFiles;
    }

    //TODO - suprascrieti metodele visit
}