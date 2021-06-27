package task1_and_2;

//Task 2 subpuncutul 2, 3 si tema de gandire

public class Singleton {
    private static Singleton instance;
    static int count = 0;

    private Singleton(){}

    static {
        instance = new Singleton();
    }

    public static Singleton getInstance(){
        count++;

        // Este necesar ca count sa fie declarat static atata vreme cat
        // este folosit intr-o metoda statica

        return instance;
    }
}

// Tema de gandire: Fenomenul care s-ar putea intampla este o confuzie totala intre thread-urile
// care folosesc singleton. Daca se apeleaza id-ul unui thread de exemplu care foloseste singleton
// se poate obtine un alt id. Se face o confuzie totala intre thread-uri.