package task3;

public class Test3 {
    public static void main(String[] args){
        Student s1 = new Student();
        Student s2 = new Student();

        s1.setName("Mircea");
        s1.setYear(2);

        s2.setName("Mircea");
        s2.setYear(2);

        System.out.println(s1.equals(s2));
    }
}