package Lab_6;

import java.util.ArrayList;

public class Test {
    public static void main(String[] args) {

        Car car1 = new Car(8000,2020, "Dacia");
        Car car2 = new Car(12000,2018, "Skoda");
        Car car3 = new Car(15000, 2020, "Honda");
        Dealership deal = new Dealership();

        System.out.println("Task 1 si 2:\n");

        int price = deal.getFinalPrice(car1);
        System.out.println("Pretul final al masinii din brand-ul " + car1.getType() + " din anul " + car1.getYear() + " este " + price);

        price = deal.getFinalPrice(car2);
        System.out.println("Pretul final al masinii din brand-ul " + car2.getType() + " din anul " + car2.getYear() + " este " + price);

        price = deal.getFinalPrice(car3);
        System.out.println("Pretul final al masinii din brand-ul " + car3.getType() + " din anul " + car3.getYear() + " este " + price);

        System.out.println("\n\nTask 3 si 4:\n");

        Offer clientOffer = deal.getOffer();
        deal.negociate(car1, clientOffer);
        deal.negociate(car2, clientOffer);
        deal.negociate(car3, clientOffer);

        System.out.println("\nTask 5:\n");
        Car car4 = new Car(9750,2020, "Dacia");
        Car car5 = new Car(12200,2020, "Skoda");
        Car car6 = new Car(15500, 2020, "Honda");

        ArrayList<Car> List = new ArrayList<>();
        List.add(car1);
        List.add(car2);
        List.add(car3);
        List.add(car4);
        List.add(car5);
        List.add(car6);
        System.out.println("Before: ");

        int i;

        for(i = 0; i < List.size(); i++)
            System.out.println((i + 1) + ") "  + List.get(i).getType() + " - " + List.get(i).getYear() +
                            " - " + List.get(i).getPrice());

        System.out.print("\n");
        List.removeIf((car) -> car.getPrice() > 10000);

        for(i = 0; i < List.size(); i++)
            System.out.println((i + 1) + ") "  + List.get(i).getType() + " - " + List.get(i).getYear() +
                    " - " + List.get(i).getPrice());
    }
}
