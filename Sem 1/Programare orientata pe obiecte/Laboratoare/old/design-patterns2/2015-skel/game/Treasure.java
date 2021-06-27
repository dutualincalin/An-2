package game;

import java.util.Random;
import java.util.List;

/**
 * Class representing a "treasure". The map contains treasures that the heroes
 * will collect.
 *
 * The treasures have a special story(lore) associated with them.
 * Now treasures are also weapons with a DamageType and Damage value
 */
public class Treasure {

	protected String name;
	protected String lore;
	protected int posx, posy;
	protected DamageType dmgT;
	protected int dmg;

	public Treasure(String name, String lore, DamageType dmgT, int dmg) {
		this.name = name;
		this.lore = lore;
		this.dmgT = dmgT;
		this.dmg = dmg;
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

	public DamageType getDamageType() {
		return dmgT;
	}

	public void setDamageType(DamageType dmgT) {
		this.dmgT = dmgT;
	}

	public int getDmg() {
		return dmg;
	}

	public void setDmg(int dmg) {
		this.dmg = dmg;
	}
}

/**
 * Builds random treasure objects. Hides the treasure creation mechanism using
 * a factory method.
 *
 */
class TreasureFactory {
	private static TreasureFactory factory = null;

	private DamageType[] types = DamageType.values();
	// private int size = types.size();
	private Random rand = new Random();

	public DamageType randomDamageType()  {
		return types[rand.nextInt(types.length)];
	}

	public static TreasureFactory getInstance()	{

		if (factory == null)
			factory = new TreasureFactory();
		return factory;
	}

	private TreasureFactory() {	}

	public Treasure createTreasure() {

		String [] names = {"Sword of Justice",
							"Leg of St Andrew",
							"Rabbit's Foot",
							"5-leaf Clover",
							"Shield of the Wise",
							"Dumbbels"};
		String [] lore = {"it looks quite old",
						  "you've heard of this before",
						  "tales of this legendary item are told in each tavern",
						  "the devourer of souls"};

		return new Treasure(names[rand.nextInt(names.length)],lore[rand.nextInt(lore.length)],randomDamageType(),rand.nextInt(30) + 10);
	}
}


/* How to get x3 damage modifier:
	Blunt + Warrior
	Magic + Mage
	Poison + Priest
*/


enum DamageType {
	Blunt, Magic, Poison
}
