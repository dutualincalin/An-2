public class TestPar {
    public static void main(String[] args){
        Par numbers = new Par();
        
        numbers.add(5);
        numbers.add(10);
        numbers.add(56);
        numbers.add(14);
        numbers.add(19);
        numbers.add(13);

        System.out.println("LinkedHashSet:");
        for (Integer p: numbers) {
            System.out.println(p);
        }


        Par2 numbers2 = new Par2();

        numbers2.add(5);
        numbers2.add(10);
        numbers2.add(56);
        numbers2.add(14);
        numbers2.add(19);
        numbers2.add(13);

        System.out.println("\nHashSet:");
        for (Integer p: numbers2) {
            System.out.println(p);
        }

        Par3 numbers3 = new Par3();

        numbers3.add(5);
        numbers3.add(10);
        numbers3.add(56);
        numbers3.add(14);
        numbers3.add(19);
        numbers3.add(13);

        System.out.println("\nTreeSet:");
        for (Integer p: numbers3) {
            System.out.println(p);
        }

        // LinkedHashSet asaza elementele in ordinea inserarii, HashSet le retine in ordine
        // aleatoare, iar TreeSet in ordine crescatoare.
    }
}
