package fourth;

import java.util.ArrayList;

public abstract class Album {
    ArrayList<Song> songs = new ArrayList<>();

    abstract void addSong(Song song);

    void removeSong(int i){
        songs.remove(i);
    }

    public String toString(){
        int i;
        String str = "Lista cu melodiile din album:\n";
        for(i = 0; i < songs.size(); i++)
            str = str + i + ") " + songs.get(i).name + " - " + songs.get(i).composer + ", " + songs.get(i).id + "\n";
        return str;
    }
}
