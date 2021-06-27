package task1_and_2;

import java.util.Random;

//Task 1

public class PasswordMaker {
    private final int MAGIC_NUMBER = 14;
    private final String MAGIC_STRING;
    private final String password;

    PasswordMaker(String name){
        Random generator = new Random();
        RandomStringGenerator rand20 = new RandomStringGenerator(20, "abcdefghijklmnopqrstuvwxyz");
        MAGIC_STRING = rand20.next();

        RandomStringGenerator rand10 = new RandomStringGenerator(10 , MAGIC_STRING);
        String alfabet = rand10.next();

        RandomStringGenerator lastrandom = new RandomStringGenerator(MAGIC_NUMBER, alfabet);
        password = lastrandom.next() + name.length() + generator.nextInt(101);
    }

    String getPassword(){
        return password;
    }
}
