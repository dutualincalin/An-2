package game;

import java.util.List;

public abstract class Hero {

	protected String name;
	protected List<Treasure> inventory;
	protected int posx, posy;    

	/* Hero actions */ 
	public void move(Direction direction) {

		if (direction == Direction.E)
			posy = (posy + 1) % GameState.MAP_SIZE;
		if (direction == Direction.W)
			posy = (posy + GameState.MAP_SIZE -1) % GameState.MAP_SIZE;
		if (direction == Direction.S)
			posx = (posx + 1) % GameState.MAP_SIZE;
		if (direction == Direction.N)
			posx = (posx + GameState.MAP_SIZE -1) % GameState.MAP_SIZE;

		//TODO the game state must inform its observers about this move
	}

	public void collect(Treasure treasure) {
	
		// TODO

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
}

// TODO
// Warrior
// - extra attribute: damage (aka strength)

// Priest
// - extra attribute: knowledge

// Mage
// - additional attack: magicAttack

// In this lab they don't fight, so now just implement a different toString() 
// for each of them

// TODO a factory for creating heroes
class HeroFactory {
	
}

enum HeroType {
	WARRIOR, MAGE, PRIEST
}

enum Direction {
	S, N, E, W
}



