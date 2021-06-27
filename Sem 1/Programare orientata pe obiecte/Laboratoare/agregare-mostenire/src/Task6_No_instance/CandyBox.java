package Task6_No_instance;

import java.util.ArrayList;

public class CandyBox {
    private String flavor;
    private String origin;
    ArrayList<CandyBox> Boxes;

    public String getFlavor() {
        return flavor;
    }

    public String getOrigin() {
        return origin;
    }

    public void printDim(){}

    public CandyBox(String flavor, String origin){
        this.flavor = flavor;
        this.origin = origin;
    }

    public CandyBox(){
        Boxes = new ArrayList<>();
    }
}

