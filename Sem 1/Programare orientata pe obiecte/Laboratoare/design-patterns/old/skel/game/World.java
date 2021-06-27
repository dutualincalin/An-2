package com.oop_pub.design_patterns.game;

import com.oop_pub.design_patterns.entities.Hero;
import com.oop_pub.design_patterns.entities.Treasure;
import com.oop_pub.design_patterns.factories.TreasureFactory;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Random;

public class World extends Observable {

    public static final int MAP_SIZE = 5;
    public static final int EMPTY_SPOT = 0;
    public static final int OBSTACLE_SPOT = 1;
    public static final int HERO_SPOT = 2;
    public static final int TREASURE_SPOT = 3;

    private ArrayList<Hero> party = new ArrayList<Hero>();
    private ArrayList<Treasure> treasures = new ArrayList<Treasure>();
    private boolean adventureStarted = false;

    private int[][] map = new int[][]
            {
                    {0, 0, 1, 1, 0},
                    {0, 0, 0, 1, 0},
                    {0, 0, 0, 0, 0},
                    {0, 0, 1, 0, 0},
                    {0, 0, 0, 0, 0}
            };

    private static World world = null;

    private World() {
    }

    public static World getInstance() {

        if (world == null)
            world = new World();
        return world;
    }

    public void update() {

        this.setChanged();
        this.notifyObservers();
    }

    public void populateTreasures(int numTreasures) {

        Random rand = new Random();

        if (numTreasures > MAP_SIZE * MAP_SIZE) {
            System.err.println("Too many treasures");
            return;
        }

        //TODO place treasures randomly on the map
    }

    public void removeTreasure(Treasure t) {
        treasures.remove(t);
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

}