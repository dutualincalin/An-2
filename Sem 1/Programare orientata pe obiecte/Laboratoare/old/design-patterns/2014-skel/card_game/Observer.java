package card_game;

public interface Observer{
	void notifyEvent(GameEvent e);
}

class ScoreCounter{
	
	// TODO implement Observer	
	// TODO hold information on scores for each player and update accordingly (for Victory cards etc), when notified

	/**
	 * Prints the score for each player in the game who had played at least a turn.
	 */
	public void printScore(){
	}
}


class GameLogger{	
	
	//TODO implement Observer
	//When notified, it prints the current player and details about what card he played/bought
	
}
