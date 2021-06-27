package Task6_No_instance;

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

    public void printDim(){
        System.out.println("ChocAmor:\n" + "Length = " + length + "\n");
    }

    public String toString() {
        return "The " + super.getOrigin() + " " + super.getFlavor() + " with a volume of " + getVolume() + "ml";
    }
}
