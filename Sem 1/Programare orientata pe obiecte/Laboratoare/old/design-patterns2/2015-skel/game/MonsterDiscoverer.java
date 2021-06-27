package game;

import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;

/**
 * Prints the weakness of a monster when a hero discovers it.
 *
 */
class MonsterDiscoverer implements Observer {

    public void update(Observable o, Object arg) {

        GameState gs = GameState.getInstance();

        for (Hero h: gs.getParty())
        {
            for (Monster t : gs.getMonsters())

                if (h.getPosx() == t.getPosx() &&
                    h.getPosy() == t.getPosy()) {
                        System.out.println("Hero " + h.getName() + " has found a monster: " + t.getName());
                        System.out.println(t);

                        h.setTarget(t);

                    }
        }

    }
}
