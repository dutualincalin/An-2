package Task3;

import java.util.Objects;

public class CandyBox {
    private String flavor;
    private String origin;

    public String getFlavor() {
        return flavor;
    }

    public String getOrigin() {
        return origin;
    }

    public CandyBox(){}

    public CandyBox(String flavor, String origin){
        this.flavor = flavor;
        this.origin = origin;
    }

    public float getVolume(){
        return 0;
    }

    public String toString(){
        return "In aceasta cutie se gasesc bomboane cu aroma de " + flavor + " si sunt facute in " + origin;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CandyBox)) return false;
        CandyBox candyBox = (CandyBox) o;
        return flavor.equals(candyBox.flavor) &&
                origin.equals(candyBox.origin);
    }

    //Vom compara doua obiecte in functie de flavor si origin
}

