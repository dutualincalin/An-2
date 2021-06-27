package Task2;

public class ChocAmor extends CandyBox {
    private float length;

    public ChocAmor(){}

    public ChocAmor(String flavor, String origin, float length) {
        super(flavor, origin);
        this.length = length;
    }

    public float getVolume(){
        return length * length * length;
    }

    public String toString() {
        return "The " + super.getOrigin() + " " + super.getFlavor() + " has a volume of " + getVolume() + "ml";
    }
}
