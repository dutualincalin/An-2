package com.oop_pub.design_patterns.entities;


/**
 * Class representing a "treasure". The map contains treasures that the heroes
 * will collect.
 *
 * The treasures have a special story(lore) associated with them.
 */
public class Treasure {

    protected String name;
    protected String lore;
    protected int posx, posy;

    public Treasure(String name, String lore) {
        this.name = name;
        this.lore = lore;
    }

    public int getPosx() {
        return posx;
    }

    public void setPosx(int posx) {
        this.posx = posx;
    }

    public int getPosy() {
        return posy;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLore() {
        return lore;
    }

    public void setLore(String lore) {
        this.lore = lore;
    }

    public void setPosy(int posy) {
        this.posy = posy;
    }
}