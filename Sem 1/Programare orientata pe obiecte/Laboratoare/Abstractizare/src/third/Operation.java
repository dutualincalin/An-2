package third;

public class Operation implements Plus, Minus, Mult, Div{
    public float number;

    public Operation(int number){
        this.number = (float) number;
    }

    public void plus(float number) {
        this.number += number;
    }

    public void minus(float number) {
        this.number -= number;
    }

    public void mult(float number) {
        this.number *= number;
    }

    public void div(float number) {
        if(number != 0f)
        this.number /= number;
    }

    public float getNumber(){
        return number;
    }
}
