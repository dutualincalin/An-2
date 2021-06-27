package card_game;

interface Observable {
	
	boolean addObserver(Observer o);	
	boolean removeObserver(Observer o);
}

public class PlayArea {
	
	private String currentPlayer;	
	
	//TODO implement Observable

	/* TODO implement an undoable behavior	
		
		This class needs to hold a collection of all the Commands that have been issued (played), *in order*, and a reference to the last issued Command.
		When someone decides to undo a Command, you need to
		- undo the actual action of the Command
		- get back to the previous Command
		- keep the "undid" Commands in case you want to "redo"
		When you play a fresh Command, you need to delete the "undid" Commands from your Collection.

		Example: you played GameCommands C1, C2, C3. Reference to last Command: C3. 
		You undo. Your collection of Commands is still C1, C2, C3, but last Command becomes C2.
		You undo again. Your collection is the same, but last Command becomes C1.
		You redo. Your collection remains the same, last Command is C2.
		You play a fresh Command, C4. Your collection will become C1, C2, C4 (C3 was "undid", so we toss that one).
	*/

	public void setPlayer(String p){
		currentPlayer = p;
	}
	public void play(GameCommand c){
		//TODO
	}	
}

class GameEvent{
	Card card;
	String player;
	GameAction action;
	
	public GameEvent(Card card, String player, GameAction action){
		this.card = card;
		this.player = player;
		this.action = action;
	}
	
	public Card getCard(){
		return card;
	}
	
	public String getPlayer(){
		return player;
	}
	
	public GameAction getAction(){
		return action;
	}
}

