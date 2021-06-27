package com.oop_pub.exceptions.ex1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class MainEx1 {
    private static void readAndPrintLine() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

        try{
           String line = reader.readLine();
           System.out.println(line);
        } catch (IOException e) {
            System.out.println("No file found.");
        } finally {
            try {
                reader.close();
            } catch (IOException e) {
                System.out.println("No file found.");
            }
        }
    }

    public static void main(String[] args) {
        readAndPrintLine();
    }
}
