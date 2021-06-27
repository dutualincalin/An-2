package Task2;

public class Test {
    public static void main(String []args){
        Lindt bobo1 = new Lindt("Chocolate", "Switzerland", 7F, 10F, 10F);
        ChocAmor bobo2 = new ChocAmor("Chocolate", "Great Britain", 10F);
        Baravelli bobo3 = new Baravelli("Rom", "Great Britain", 5F, 10F);

        System.out.println(bobo1);
        System.out.println(bobo2);
        System.out.println(bobo3);
    }
}
