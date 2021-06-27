package game;

import java.util.Random;

public class Monster {
	private String name;
	private DamageType weakness;
	private int posx, posy;
	private int hp;

	public Monster(String name, DamageType weakness) {
		this.name = name;
		this.weakness = weakness;
		this.hp = 100;
	}

	/* Getters and setters */
	public int getPosy() {
		return posy;
	}

	public void setPosy(int posy) {
		this.posy = posy;
	}

	public int getPosx() {
		return posx;
	}

	public void setPosx(int posx) {
		this.posx = posx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getHP() {
		return hp;
	}

	public void setHP(int hp) {
		this.hp = hp;
	}

	public DamageType getWeakness() {
		return weakness;
	}

	public int getDmg() {
		return new Random().nextInt(26) + 25;
	}

	public String toString() {
		return this.getName() + "is vulnerable agains: " + this.getWeakness();
	}
}


/**
 * Builds random monster objects. Hides the monster creation mechanism using
 * a factory method.
 *
 */
class MonsterFactory {
	private static MonsterFactory factory = null;

	private DamageType[] types = DamageType.values();
	private Random rand = new Random();

	public DamageType randomDamageType()  {
		return types[rand.nextInt(types.length)];
	}

	public static MonsterFactory getInstance()	{

		if (factory == null)
			factory = new MonsterFactory();
		return factory;
	}

	private MonsterFactory() {	}

	public Monster createMonster() {

		String [] names = { "Krark", "Okur", "Krerag", "Nukorg", "Ikag", "Krougrok",
							"Xaarut", "Yuwegruk", "Niukug", "Exikor"};

		return new Monster(names[rand.nextInt(names.length)],randomDamageType());
	}
}
