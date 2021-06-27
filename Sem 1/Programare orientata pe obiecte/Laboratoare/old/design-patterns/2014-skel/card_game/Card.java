package card_game;

enum CardType{
	ACTION,
	VICTORY,
	MONEY
}

public abstract class Card {
	protected CardType type;
	
	/**
	 * Play the card.
	 * @return a result of the action performed by the card:
	 *  the number of virtual coins provided by the actions, 
	 *  the value in coins of a money(treasure) card,
	 *  the value in victory points for a Victory Card.
	 */
	public abstract int play();
	public abstract int getPrice();
	public CardType getType(){
		return type;
	}
}

class MarketActionCard extends Card {
	
	public MarketActionCard(){
		type = CardType.ACTION;
	}
	
	public  int play(){
		return 1;
	}
	
	public  int getPrice(){
		return 5;
	}
	
	public String toString(){
		return "Market";
	}
}

class VillageActionCard extends Card {
	
	public VillageActionCard(){
		type = CardType.ACTION;
	}
	
	public  int play(){
		return 0;
	}
	
	public  int getPrice(){
		return 3;
	}
	
	public String toString(){
		return "Village";
	}
}

class EstateVictoryCard extends Card {
	
	public EstateVictoryCard(){
		type = CardType.VICTORY;
	}
	public  int play(){
		return 1;
	}
	
	public  int getPrice(){
		return 2;
	}
	
	public String toString(){
		return "Estate";
	}
}

class ProvinceVictoryCard extends Card {
	
	public ProvinceVictoryCard(){
		type = CardType.VICTORY;
	}
	
	public  int play(){
		return 6;
	}
	
	public  int getPrice(){
		return 8;
	}
	
	public String toString(){
		return "Province";
	}
}

class CopperTreasureCard extends Card{
	
	public CopperTreasureCard(){
		type = CardType.MONEY;
	}
	
	public  int play(){
		return 1;
	}
	
	public  int getPrice(){
		return 0;
	}
	
	public String toString(){
		return "Copper";
	}
}

class GoldTreasureCard extends Card{
	
	public GoldTreasureCard(){
		type = CardType.MONEY;
	}
	
	public  int play(){
		return 3;
	}
	public  int getPrice(){
		return 6;
	}
	
	public String toString(){
		return "Copper";
	}
}


