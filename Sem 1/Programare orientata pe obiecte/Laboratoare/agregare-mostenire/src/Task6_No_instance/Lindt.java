package Task6_No_instance;

public class Lindt extends CandyBox {
    private float length;
    private float width;
    private float height;

    public Lindt() {
    }

    public Lindt(String flavor, String origin, float length, float width, float height){
        super(flavor, origin);
        this.length = length;
        this.width = width;
        this.height = height;
    }

    public float getVolume(){
        return length * height * width;
    }

    public void printDim(){
        System.out.println("Lindt:\n" + "Length = " + length + ";\nWidth = " + width + ";\nHeight = " + height + "\n");
    }

    public String toString() {
        return "The " + super.getOrigin() + " " + super.getFlavor() + " with a volume of " + getVolume() + "ml";
    }
}
