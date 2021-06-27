package entities;

import entities.Treasure.DamageType;
import strategies.AttackStrategy;
import strategies.DefenseStrategy;

public class Priest extends Hero {

    private int knowledge;

    public Priest(String name, int i) {

        this.name = name;
        this.knowledge = i;
        this.hp = 100;
        this.damageType = DamageType.Poison;
    }

    @Override
    public void attack() {
        // TODO check if hero can attack (at his position, there should be a monster)
    	//       ->use canAttack() method from the base class
    	// * choose what strategy you should use according to the Hero's HP
    	//       -> use the Strategy object from the base class
        // * if it can use the strategy to attack and update Hero HP (deduct target damage)
        // * and print a message
    }

    @Override
    public String toString() {
        return new String("Sneaky Priest " + name + " of knowledge " + knowledge);
    }

    public int getBaseDamage() {
        return knowledge;
    }
}
