import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.PriorityQueue;

public class Test {
    public static void main(String[] args){
        ArrayList<Student> studenti = new ArrayList<>();

        studenti.add(new Student("Florea", "Eduard", 1, 9.80));
        studenti.add(new Student("Popescu", "George", 2, 9.20));
        studenti.add(new Student("Petruc", "Razvan", 3, 9.20));
        studenti.add(new Student("Student", "Ideal", 4, 10));
        studenti.add(new Student("Popescu", "Andrei", 5, 9.20));

        System.out.println("Sortare dupa compareTo:");

        Collections.sort(studenti);

        for(Student o : studenti)
            System.out.println(o);


        System.out.println("\n\nDupa de sortare lambda:");

        studenti.sort((o1, o2) -> Double.compare(o2.getAverageGrade(), o1.getAverageGrade()));

        for(Student o : studenti)
            System.out.println(o);


        PriorityQueue<Student> queue = new PriorityQueue<>(5,
                Comparator.comparingLong(Student::getId));

        queue.addAll(studenti);

        System.out.println("\n\nElementele in queue:");
        for(Student o : queue){
            System.out.println(o);
        }

        HashMap<Student, LinkedList<String>> materii = new HashMap<>();

        LinkedList<String> set1 = new LinkedList<>();
        set1.add("POO");
        set1.add("AA");
        set1.add("IOCLA");

        LinkedList<String> set2 = new LinkedList<>();
        set2.add("POO");
        set2.add("TS");
        set2.add("EEA");

        materii.put(new Student("Florea", "Eduard", 1, 9.80), set1);
        materii.put(new Student("Popescu", "George", 2, 9.20), set1);
        materii.put(new Student("Petruc", "Razvan", 3, 9.20), set2);
        materii.put(new Student("Student", "Ideal", 4, 10), set2);
        materii.put(new Student("Popescu", "Andrei", 5, 9.20), set1);


        System.out.println("\n\nContinutul map-ului:\n" + materii.entrySet());
    }
}
