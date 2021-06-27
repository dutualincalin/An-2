package fourth;

public class BadAlbum extends Album{

    public int palindrom(int number){
        int old = number;
        int reversed = 0;

        while (number != 0){
            reversed = (number % 10) + reversed * 10;
            number /= 10;
        }

        if (reversed == old)
            return 1;
        return 0;
    }

    public void addSong(Song song){
        if(song.name.length() == 3 && palindrom(song.id) == 1) {
            songs.add(song);
        }
    }

}
