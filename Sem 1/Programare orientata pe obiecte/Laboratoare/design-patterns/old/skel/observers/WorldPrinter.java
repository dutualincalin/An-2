package com.oop_pub.design_patterns.observers;

/**
 * Observer that prints the game's world (the map with all the treasures,
 * heroes, obstacles)
 */

import com.oop_pub.design_patterns.entities.Hero;
import com.oop_pub.design_patterns.entities.Treasure;
import com.oop_pub.design_patterns.game.World;

import java.util.Observable;
import java.util.Observer;

public class WorldPrinter implements Observer {

    @Override
    public void update(Observable o, Object arg) {
        // TODO obtain the World's map, treasures and heroes
        // print the map
        // e.g.
        // 0  1  1  1  0
        // H  T  0  1  0
        // 0  0  T  0  0
        // 0  0  0  T  T
        // 0  T  0  0  0
        // T - treasure, H - hero, 1 - obstacle
    }

}