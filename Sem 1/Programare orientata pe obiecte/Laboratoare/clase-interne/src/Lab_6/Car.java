package Lab_6;

public class Car {
    private int price;
    private int year;
    private CarType type;

    enum CarType{
        Dacia,
        Skoda,
        Honda
    }

    public Car(int price, int year, String type){
        this.price = price;
        this.year = year;

        if(type.equals("Dacia")) {
            this.type = CarType.Dacia;
        }

        if(type.equals("Skoda")) {
            this.type = CarType.Skoda;
        }

        if(type.equals("Honda")) {
            this.type = CarType.Honda;
        }
    }

    public int getPrice() {
        return price;
    }

    public int getYear() {
        return year;
    }

    public String getType() {
        if (this.type.equals(CarType.Dacia)){
            return("Dacia");
        }

        if (this.type.equals(CarType.Skoda)){
            return("Skoda");
        }

        return("Honda");
    }
}
