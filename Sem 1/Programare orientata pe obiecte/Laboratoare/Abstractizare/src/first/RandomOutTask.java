package first;

import java.util.Random;

public class RandomOutTask implements Task {
    private int number;

    public RandomOutTask(){
        Random generator = new Random();
        number = generator.nextInt(501);
    }

    public void execute(){
        System.out.println("Ce zici de numarul " + number);
    }
}
