package Task5;

public class Test {
    public static void main(String []args){
        CandyBox Cadou = new CandyBox();
        CandyBox bobo1 = new Lindt("Chocolate", "Lindt", 7F, 10F, 10F);
        CandyBox bobo2 = new ChocAmor("Chocolate", "ChocAmor", 10F);
        CandyBox bobo3 = new Baravelli("Rom", "Baravelli", 5F, 10F);
        Cadou.Boxes.add(bobo1);
        Cadou.Boxes.add(bobo2);
        Cadou.Boxes.add(bobo3);

        for(int i = 0; i < Cadou.Boxes.size(); i++){
            if(Cadou.Boxes.get(i) instanceof Lindt)
                ((Lindt) Cadou.Boxes.get(i)).printLindtDim();

            if(Cadou.Boxes.get(i) instanceof ChocAmor)
            ((ChocAmor) Cadou.Boxes.get(i)).printChocAmorDim();

            if(Cadou.Boxes.get(i) instanceof Baravelli)
                ((Baravelli) Cadou.Boxes.get(i)).printBaravelliDim();
        }
    }
}
