package Task1;

public class Main {
    public static void main(String[] args){
        Complex nrc1 = new Complex();
        nrc1.showNumber();

        Complex nrc2 = new Complex(3,4);
        nrc2.showNumber();

        Complex nrc3 = new Complex(nrc2);
        nrc3.showNumber();

        Complex nrc4 = new Complex();
        nrc4.addWithComplex(nrc2);
        nrc4.addWithComplex(nrc3);
        nrc4.showNumber();
    }
}