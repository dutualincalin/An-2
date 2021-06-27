package Lab_6;

import java.util.Calendar;
import java.util.Random;

public class Dealership {
    Random random = new Random();

    public Offer getOffer(){
        return new  Offer () {
            public int getDiscount(Car car) {
                return 1000;
            }
        };
    }

    private class BrandOffer implements Offer{
        public int getDiscount(Car car) {
            if (car.getType().equals("Dacia")){
                return car.getPrice() / 10;
            }

            return 0;
        }
    }

    private class DealerOffer implements Offer{
        public int getDiscount(Car car) {
            return 150 * (Calendar.getInstance().get(Calendar.YEAR) - car.getYear());
        }
    }

    private class SpecialOffer implements Offer{
        public int getDiscount(Car car) {
            return random.nextInt(car.getPrice()/5 + 1);
        }
    }

    public int getFinalPrice(Car car){
        int price;

        BrandOffer brand = new BrandOffer();
        price = car.getPrice() - brand.getDiscount(car);

        DealerOffer dealer = new DealerOffer();
        price -= dealer.getDiscount(car);

        SpecialOffer special = new SpecialOffer();
        price -= special.getDiscount(car);

        if(price > 0) {
            return price;
        }

        else {
            System.out.print("Eroare la calcularea pretului final");
            return -1;
        }
    }

    void negociate(Car car, Offer offer){
        int car_price;
        int price;

        car_price = car.getPrice();
        System.out.println("Initial price: " + car.getPrice() + " euros");

        BrandOffer brand = new BrandOffer();
        price = brand.getDiscount(car);
        car_price -= price;
        System.out.println("Applying Brand discount: " + price + " euros");

        DealerOffer dealer = new DealerOffer();
        price = dealer.getDiscount(car);
        car_price -= price;
        System.out.println("Applying Dealer discount: " + price + " euros");

        SpecialOffer special = new SpecialOffer();
        price = special.getDiscount(car);
        car_price -= price;
        System.out.println("Applying Special discount: " + price + " euros");

        System.out.println("Final price: " + car_price + " euros");

        if(random.nextInt(2) == 1) {
            price = offer.getDiscount(car);
            car_price -= price;
            System.out.println("Applying Client discount: " + price + " euros");
            System.out.println("Final price after negotiation: " + car_price + " euros\n");
        }

        else System.out.print("\n");
    }
}
