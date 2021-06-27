package Task6;

public class Area{
    CandyBox gift;
    int number;
    String street;

    public Area(){}

    public Area(CandyBox gift, int number, String street){
        this.gift = gift;
        this.number = number;
        this.street = street;
    }

    public void getBirthdayCard(){
        System.out.println(street + ", Nr." + number + "\nLa multi ani!\n");
        for(int i = 0; i < gift.Boxes.size(); i++){
            System.out.println(i+1 + ") " + gift.Boxes.get(i));
        }
        System.out.println("\n");
    }
}
