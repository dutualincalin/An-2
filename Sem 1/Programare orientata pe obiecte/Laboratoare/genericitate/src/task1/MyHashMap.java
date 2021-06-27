package task1;

import java.util.LinkedList;

public class MyHashMap <C, V>{
    private int size = 0;
    private LinkedList<Entry>[] values = new LinkedList[3];

    private class Entry{
        public C cheie;
        public V valoare;

        private Entry(C cheie, V valoare){
            this.cheie = cheie;
            this.valoare = valoare;
        }
    }

    public int getSize(){
        return size;
    }

    private void resizeMap(){
        LinkedList<Entry>[] old = values;
        values  = new LinkedList[size * 2];
        size = 0;

        for(LinkedList<Entry> list : old){
            if(list != null){
                for(Entry l : list){
                    put(l.cheie, l.valoare);
                }
            }
        }
    }

    public void put(C cheie, V valoare){
        if(values.length == size){
            resizeMap();
        }

        int k = cheie.hashCode() % values.length;
        if(values[k] == null){
            values[k] = new LinkedList<>();
            values[k].add(new Entry(cheie, valoare));
            size++;
        }

        else{
            for(Entry elem : values[k]){
                if(elem.cheie.equals(cheie))
                    elem.valoare = valoare;
            }
        }
    }

    public V get(C cheie){
        int k = cheie.hashCode() % values.length;

        if(values[k] == null){
            return null;
        }

        for(Entry elem : values[k]){
            if(elem.cheie.equals(cheie)){
                return elem.valoare;
            }
        }

        return null;
    }
}
