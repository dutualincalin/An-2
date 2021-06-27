package com.oop_pub.design_patterns.entities;

import com.oop_pub.design_patterns.game.World;

import java.util.List;
import java.util.ArrayList;

public abstract class Hero {

    protected String name;
    protected List<Treasure> inventory;
    protected int posx, posy;

    /* Hero actions */
    public void move(Direction direction) {

        World world = World.getInstance();

        switch (direction) {
            case E:
                posy = (posy + 1) % World.MAP_SIZE;
                break;
            case W:
                posy = (posy + World.MAP_SIZE - 1) % World.MAP_SIZE;
                break;
            case S:
                posx = (posx + 1) % World.MAP_SIZE;
                break;
            case N:
                posx = (posx + World.MAP_SIZE - 1) % World.MAP_SIZE;
                break;

        }

        //TODO the world must be informed in order to update its observers about this move
    }

    public void collect(Treasure treasure) {

        //TODO
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

    public enum Direction {
        S, N, E, W
    }

    public enum Type {
        WARRIOR, MAGE, PRIEST
    }

}
