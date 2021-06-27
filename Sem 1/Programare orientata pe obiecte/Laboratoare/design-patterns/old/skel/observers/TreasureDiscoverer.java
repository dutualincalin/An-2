package com.oop_pub.design_patterns.observers;

import com.oop_pub.design_patterns.entities.Hero;
import com.oop_pub.design_patterns.entities.Treasure;
import com.oop_pub.design_patterns.game.World;

import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;

/**
 * Prints the lore of a treasure when a hero discovers it.
 */
public class TreasureDiscoverer implements Observer {

    public void update(Observable o, Object arg) {
        // TODO
        // check if any hero is in an area containing a treasure
        // print some message
        // remove treasure from map and
        // add to specific hero's inventory
    }
}
