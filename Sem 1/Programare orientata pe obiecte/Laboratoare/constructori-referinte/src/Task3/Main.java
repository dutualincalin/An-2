package Task3;

public class Main{
    public static void main(String[] args){
        float[] k = {1 ,2.4F ,3.3F ,4 ,3, 6.7F};
        Polygon pol = new Polygon(k);

        for(int i = 0; i < k.length/2; i++) {
            System.out.println(pol.point[i]);
        }
    }
}
