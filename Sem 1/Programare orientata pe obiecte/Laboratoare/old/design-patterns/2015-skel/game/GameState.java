package game;

import java.util.ArrayList;

/**
 * Class representing the game's world. It is observable by other observer-type 
 * classes. 
 *
 */
public class GameState {
	public static final int MAP_SIZE = 5;
	
	private ArrayList<Hero> party = new ArrayList<Hero>();
	private ArrayList<Treasure> treasures = new ArrayList<Treasure>();
	private boolean adventureStarted = false;
	
	// you can change how the map is created if you'd like
	public int [][] map = new int [][] 
			{
			{0, 1, 1, 1, 0},
			{0, 0, 0, 1, 0},
			{0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0}
			};
	
	
		
	public void populateTreasures(int numTreasures) {
		
		if (numTreasures > MAP_SIZE*MAP_SIZE) {
			System.err.println("Too many treasures");
			return;
		}
	
		//TODO create Treasures
		
	}
	
	
	public ArrayList<Hero> getParty() {
		return party;
	}

	public void setParty(ArrayList<Hero> party) {
		this.party = party;
	}

	public ArrayList<Treasure> getTreasures() {
		return treasures;
	}

	public void setTreasures(ArrayList<Treasure> treasures) {
		this.treasures = treasures;
	}

	public boolean isAdventureStarted() {
		return adventureStarted;
	}

	public void setAdventureStarted(boolean adventureStarted) {
		this.adventureStarted = adventureStarted;
	}


	public int[][] getMap() {
		return map;
	}

	public void setMap(int[][] map) {
		this.map = map;
	}
	
}
