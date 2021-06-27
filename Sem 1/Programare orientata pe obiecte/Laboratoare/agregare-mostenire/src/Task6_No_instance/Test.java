package Task6_No_instance;

public class Test {
    public static void main(String []args){
        CandyBox Cadou = new CandyBox();
        CandyBox bobo1 = new Lindt("Chocolate", "Lindt", 7F, 10F, 10F);
        CandyBox bobo2 = new ChocAmor("Chocolate", "ChocAmor", 10F);
        CandyBox bobo3 = new Baravelli("Rom", "Baravelli", 5F, 10F);
        Cadou.Boxes.add(bobo1);
        Cadou.Boxes.add(bobo2);
        Cadou.Boxes.add(bobo3);

        Area area = new Area(Cadou,12,"Iuliu Maniu");

        area.getBirthdayCard();

        for(int i = 0; i < Cadou.Boxes.size(); i++)
            area.gift.Boxes.get(i).printDim();
    }
}