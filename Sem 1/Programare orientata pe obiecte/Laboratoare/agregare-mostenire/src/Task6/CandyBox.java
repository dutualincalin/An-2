package Task6;

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

    public CandyBox(String flavor, String origin){
        this.flavor = flavor;
        this.origin = origin;
    }

    public CandyBox(){
        Boxes = new ArrayList<>();
    }
}

