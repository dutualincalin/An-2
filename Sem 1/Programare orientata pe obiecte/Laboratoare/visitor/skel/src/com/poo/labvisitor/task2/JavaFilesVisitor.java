package com.poo.labvisitor.task2;

import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;

import static java.nio.file.FileVisitResult.CONTINUE;

/**
 * Counter for java files of a given directory using java.nio API
 */
public class JavaFilesVisitor extends SimpleFileVisitor<Path> {

    private ArrayList<Path> javaFiles;

    public final ArrayList<Path> getJavaFiles() {
        return javaFiles;
    }


    public FileVisitResult visitFile(Path file,
                                     BasicFileAttributes attr) {
        if (attr.isRegularFile() && (file.toString().endsWith(".class")
                || file.toString().endsWith(".java"))) {

            if (javaFiles == null) {
                javaFiles = new ArrayList<>();
            }

            javaFiles.add(file);
        }
        return CONTINUE;
    }

        public static void main (String[]args) throws IOException {

            Path startingDir = Paths.get(".");
            JavaFilesVisitor filesVisitor = new JavaFilesVisitor();

            Files.walkFileTree(startingDir, filesVisitor);
            ArrayList<Path> javaFiles = filesVisitor.getJavaFiles();

            if (javaFiles == null) {
                System.out.println("Nu exista fisiere");
                return;
            }

            System.out.format("Found %d files\n", filesVisitor.getJavaFiles().size());

            for (Path p : javaFiles) {
                System.out.println(p + "; " + Files.size(p) + " bytes");
            }
        }
}
