package com.poo.lab12.reports;

public class Pair<K, V> {
    protected K key;
    protected V value;

    protected Pair(K k, V v) {
        key = k;
        value = v;
    }

    @Override
    public String toString() {
        return "Pair [key=" + key + ", value=" + value + "]";
    }
}