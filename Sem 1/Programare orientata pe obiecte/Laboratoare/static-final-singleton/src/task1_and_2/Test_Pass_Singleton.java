package task1_and_2;

public class Test_Pass_Singleton {
    public static void main(String []args) {

        //Da eroare pentru ca constructorul este privat
        //PasswordMaker_Singleton instance = new PasswordMaker_Singleton();

        PasswordMaker_Singleton instance1 = PasswordMaker_Singleton.getInstance("Boris");
        PasswordMaker_Singleton instance2 = PasswordMaker_Singleton.getInstance("Zvetlana");
        System.out.println(instance1.getPassword());
        System.out.println(instance2.getPassword());

    }
}
