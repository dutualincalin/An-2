package task1_and_2;

//Task 2 subpunctul 1

public class Eager {
    private static Eager instance = new Eager();

    private Eager() {}

    public static Eager getInstance() {
        return instance;
    }
}
