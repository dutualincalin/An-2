package task2;

public class MyVector3 implements Sumabil {
    private int x;
    private int y;
    private int z;

    public MyVector3(int x, int y, int z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    @Override
    public void addValue(Sumabil value) {
        if(value instanceof MyVector3) {
            x +=  ((MyVector3) value).getX();
            y +=  ((MyVector3) value).getY();
            z +=  ((MyVector3) value).getZ();
        }
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int getZ() {
        return z;
    }

    @Override
    public String toString() {
        return "x=" + x + "\ny=" + y + "\nz=" + z + '\n';
    }
}
