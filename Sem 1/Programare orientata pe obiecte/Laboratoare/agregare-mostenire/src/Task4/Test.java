package Task4;

public class Test {
    public static void main(String []args){
        CandyBox Cadou = new CandyBox();
        CandyBox bobo1 = new Lindt("Chocolate", "Lindt", 7F, 10F, 10F);
        CandyBox bobo2 = new ChocAmor("Chocolate", "ChocAmor", 10F);
        CandyBox bobo3 = new Baravelli("Rom", "Baravelli", 5F, 10F);
        Cadou.Boxes.add(bobo1);
        Cadou.Boxes.add(bobo2);
        Cadou.Boxes.add(bobo3);

        System.out.println("Cadoul contine:");
        for(int i = 0; i < Cadou.Boxes.size();i++)
            System.out.println("- " + Cadou.Boxes.get(i));
    }
}
