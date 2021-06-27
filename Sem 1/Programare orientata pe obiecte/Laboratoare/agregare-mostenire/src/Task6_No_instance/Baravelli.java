package Task6_No_instance;

public class Baravelli extends CandyBox {
    private float radius;
    private float height;

    public Baravelli() {
    }

    public Baravelli(String flavor, String origin, float radius, float height){
        super(flavor, origin);
        this.radius = radius;
        this.height = height;
    }

    public float getVolume(){
        return 3.14F * radius * radius * height;
    }

    public void printDim(){
        System.out.println("Baravelli:\n" + "Radius = " + radius + ";\nHeight = " + height + "\n");
    }

    public String toString() {
        return "The " + super.getOrigin() + " " + super.getFlavor() + " with a volume of " + getVolume() + "ml";
    }
}
