package Task3;

public class Test {
    public static void main(String []args){
        Lindt bobo1 = new Lindt("Chocolate", "Switzerland", 7F, 10F, 10F);
        Lindt bobo2 = new Lindt("Chocolate", "Switzerland", 7F, 10F, 10F);

         System.out.println(bobo1.equals(bobo2));
    }
}
