package task1_and_2;

public class Test_Singleton {
    public static void main(String []args) {
        Singleton instance1 = Singleton.getInstance();
        Singleton instance2 = Singleton.getInstance();
        Singleton instance3 = Singleton.getInstance();
        System.out.println(instance1.count);
        System.out.println(instance2.count);
        System.out.println(instance3.count);
    }
}
