package game;

public interface Strategy {
	public void attack(Monster m);
}


// TODO create a strategy for each hero type
/*	 - MageStrategy
		- void attack(Monster)
	 - WarriorStrategy
	 	- void attack(Monster)
	 - PriestStrategy
		- void attack(Monster)
*/


/*	Attack algorithm
		if hero type weapon found use it (x3 weapon damage)
		else if counter weapon found use it (x2 weapon damage)
		else basic attack (no bonus)
*/

//class MageStrategy implements Strategy {}

//class WarriorStrategy implements Strategy {}

//class PriestStrategy implements Strategy {}
