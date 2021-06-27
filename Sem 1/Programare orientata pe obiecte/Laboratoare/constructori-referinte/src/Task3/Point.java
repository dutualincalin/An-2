package Task3;

public class Point {
    protected float x;
    protected float y;

    public Point(float x, float y){
        this.x = x;
        this.y = y;
    }

    public void changeCoords (float x, float y){
        this.x = x;
        this.y = y;
    }

    public String toString(){
        return "( " + x + " , " + y + " )\n";
    }
}
