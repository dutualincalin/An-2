package Task1;

public class Complex {
    private int real;
    private int imaginary;

    public int getReal() {
        return real;
    }

    public void setReal(int real) {
        this.real = real;
    }

    public int getImaginary() {
        return imaginary;
    }

    public void setImaginary(int imaginary) {
        this.imaginary = imaginary;
    }

    public Complex(int real, int img){
        setReal(real);
        setImaginary(img);
    }

    public Complex(){
       this(0,0);
    }

    public Complex(Complex complex){
        real = complex.real;
        imaginary = complex.imaginary;
    }

    public void addWithComplex(Complex complex){
        this.real += complex.real;
        this.imaginary += complex.imaginary;
    }

    public void showNumber(){
        System.out.println(real + ((imaginary > 0) ? "+" : "") + imaginary + "i");
    }
}
