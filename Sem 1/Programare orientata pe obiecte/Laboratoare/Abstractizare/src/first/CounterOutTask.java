package first;

public class CounterOutTask implements Task {
    private static int contor = 0;

    public static int getContor() {
        return contor;
    }

    public static void incrementContor() {
        contor++;
    }

    public void execute(){
        incrementContor();
        System.out.println("Conturul are valoarea " + contor);
    }
}
