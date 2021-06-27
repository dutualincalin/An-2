package game;

/**
 * Class representing a "treasure". The map contains treasures that the heroes
 * will collect. 
 * 
 * The treasures have a special story(lore) associated with them.
 *
 */
public class Treasure {
	
	protected String name;
	protected String lore;
	protected int posx, posy;
	
	public Treasure(String name, String lore) {
		this.name = name;
		this.lore = lore;
	}
	
	public int getPosx() {
		return posx;
	}
	
	public void setPosx(int posx) {
		this.posx = posx;
	}
	
	public int getPosy() {
		return posy;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getLore() {
		return lore;
	}
	
	public void setLore(String lore) {
		this.lore = lore;
	}
	
	public void setPosy(int posy) {
		this.posy = posy;
	}	
}

/**
 * Builds random treasure objects. Hides the treasure creation mechanism using
 * a factory method.
 *
 */
class TreasureFactory {
	
	//TODO implement me	
	
	// ideas for treasure names and lore:
	private final String [] names = {"Sword of Justice", 
			"Leg of St Andrew", 
			"Rabbit's Foot", 
			"5-leaf Clover", 
			"Shield of the Wise"};
	
	private final String [] lore = {"it looks quite old", 
			  "you've heard of this before", 
			  "tales of this legendary item are told in each tavern"};
	
	
	public Treasure createTreasure() {	
		return null;
	}
}