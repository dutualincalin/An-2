package entities;

import entities.Treasure.DamageType;
import strategies.AttackStrategy;
import strategies.DefenseStrategy;

public class Warrior extends Hero {

    private int damage;

    public Warrior(String name, int i) {

        this.name = name;
        this.damage = i;
        this.hp = 120;
        this.damageType = DamageType.Blunt;
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
        return new String("Mighty Warrior " + name + " of strength " + damage);
    }

    public int getBaseDamage() {
        return damage;
    }
}
