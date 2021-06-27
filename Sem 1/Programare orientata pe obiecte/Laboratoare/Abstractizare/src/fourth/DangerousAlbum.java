package fourth;

public class DangerousAlbum extends Album{

    public int prim(int number){
        int i;
        for(i = 2; i < number/2; i++) {
            if (number % i == 0) return 1;
        }

        return 0;
    }

    public void addSong(Song song) {
        if (prim(song.id) == 0) {
            songs.add(song);
        }
    }
}
