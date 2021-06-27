package Task2;

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
}

