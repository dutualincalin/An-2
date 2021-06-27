package task1;

public class Test {
    public static void main(String []args){
        MyHashMap<Integer, Object> hash = new MyHashMap<>();

        hash.put(0, 2);
        hash.put(1, "You are a bit sus!\n");
        hash.put(2, 7);
        hash.put(3, "I am voting ya!");
        System.out.println(hash.get(0));
        System.out.println(hash.get(1));
        System.out.println(hash.get(2));
        System.out.println(hash.get(3));
        System.out.println("<Number of entries: " + hash.getSize() + ">");
        hash.put(1, "\nVoted by majority?");
        hash.put(2, true);
        System.out.println(hash.get(1));
        System.out.println(hash.get(2));
        System.out.println("<Number of entries: " + hash.getSize() + ">");
        hash.put(4, "\nPlayer was not the Impostor");
        hash.put(5, "1 imposter left");
        System.out.println(hash.get(4));
        System.out.println(hash.get(5));
        System.out.println("<Number of entries: " + hash.getSize() + ">");
    }
}
