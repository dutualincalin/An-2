package Task3;

public class Polygon {
    protected Point[] point;

    public Polygon(int n){
        this.point = new Point[n];
        for(int i = 0 ; i < n; i++)
            this.point[i] = new Point(0,0);
    }

    public Polygon(float[] k){
        this(k.length/2);

        for(int i = 0; i < k.length/2; i++){
            this.point[i].changeCoords(k[2*i],k[2*i+1]);
        }
    }

}
