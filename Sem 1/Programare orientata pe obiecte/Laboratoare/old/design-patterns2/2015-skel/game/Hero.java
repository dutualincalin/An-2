package game;

import java.util.List;
import java.util.ArrayList;

public abstract class Hero {

	protected String name;
	protected List<Treasure> inventory;
	protected int posx, posy;
	protected int hp;
	protected Monster target;
	//TODO add strategy object to Hero


	/* Hero actions */
	public void move(Direction direction) {

		GameState gs = GameState.getInstance();
		setTarget(null);

		if (direction == Direction.E)
			posy = (posy + 1) % GameState.MAP_SIZE;
		if (direction == Direction.W)
			posy = (posy + GameState.MAP_SIZE -1) % GameState.MAP_SIZE;
		if (direction == Direction.S)
			posx = (posx + 1) % GameState.MAP_SIZE;
		if (direction == Direction.N)
			posx = (posx + GameState.MAP_SIZE -1) % GameState.MAP_SIZE;

		gs.update();
	}

	public void collect(Treasure treasure) {

		// "removing the treasure from the map...ugly hack"
		treasure.setPosx(-1);
		treasure.setPosy(-1);

		if(inventory == null)
			inventory = new ArrayList<>();

		// this hero now has the treasure
		inventory.add(treasure);

	}

	public abstract void attack();


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

	public List<Treasure> getInventory() {
		return inventory;
	}

	public void setHP(int hp) {
		this.hp = hp;
	}

	public int getHP() {
		return this.hp;
	}

	public void setTarget(Monster m) {
		this.target = m;
	}

	public Monster getTarget() {
		return target;
	}

	public boolean canAttack() {
		return this.target != null ? true : false;
	}
}

class Warrior extends Hero {

	private int damage;
	public Warrior(String name, int i) {

		this.name = name;
		this.damage = i;
		this.hp = 120;
		//TODO initialize strategy accordingly
	}

	@Override
	public void attack() {
		// TODO check if hero can attack
		// if it can use the strategy to attack and update Hero HP (deduct target damage)
		// and print a message
	}
	@Override
	public String toString() {
		return new String("Mighty Warrior " + name + " of strength " + damage);
	}

	public int getBaseDamage() {
		return damage;
	}
}

class Priest extends Hero {

	private int knowledge;

	public Priest(String name, int i) {

		this.name = name;
		this.knowledge = i;
		this.hp = 100;
		//TODO initialize strategy accordingly
	}

	@Override
	public void attack() {
		// TODO check if hero can attack
		// if it can use the strategy to attack and update Hero HP (deduct target damage)
		// and print a message
	}

	@Override
	public String toString() {
		return new String("Sneaky Priest " + name + " of knowledge " + knowledge);
	}

	public int getBaseDamage() {
		return knowledge;
	}
}

class Mage extends Hero {

	private int magicalDamage;

	public Mage(String name, int i) {

		this.name = name;
		this.magicalDamage = i;
		this.hp = 90;
		//TODO initialize strategy accordingly
	}

	@Override
	public void attack() {
		// TODO check if hero can attack
		// if it can use the strategy to attack and update Hero HP (deduct target damage)
		// and print a message
	}

	@Override
	public String toString() {
		return new String("Powerful Mage " + name + " of strength " + magicalDamage);
	}

	public int getBaseDamage() {
		return magicalDamage;
	}
}


class HeroFactory {
	private static HeroFactory factory = null;

	public static HeroFactory getInstance() {
		if (factory == null)
			factory = new HeroFactory();
		return factory;

	}

	private HeroFactory() {	}

	private Hero createWarrior(String name) {

		return new Warrior(name, 15); // maybe replace 15 with smth random
	}

	private Hero createMage(String name) {

		return new Mage(name, 10);
	}

	private Hero createPriest(String name) {

		return new Priest(name, 20);
	}


	/**
	 *
	 * @param type the Hero type
	 * @param name
	 * @return
	 */
	public Hero createHero(HeroType type, String name) {

		switch (type) {
		case WARRIOR:
			return createWarrior(name);

		case MAGE:
			return createMage(name);

		case PRIEST:
			return createPriest(name);

		default: return null;
		}
	}
}

enum HeroType {
	WARRIOR, MAGE, PRIEST
}

enum Direction{
	S, N, E, W//, NV, NE, SE, SV
}




