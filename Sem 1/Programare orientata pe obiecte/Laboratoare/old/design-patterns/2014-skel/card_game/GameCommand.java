package card_game;

enum GameAction{
	PLAY,
	BUY
}

public abstract class GameCommand {
	protected Card c;
	protected GameAction action;
	
	public GameCommand(Card c, GameAction action){
		//TODO;
	}
	
	/**
	 * Executes the command - in the action phase it plays the card, in the
	 * buy phase it returns the price of the bought card.
	 * @return the effect of playing the given card
	 */
	public abstract int execute();
	
	public Card getCard(){
		return c;
	}
	public GameAction getType(){
		return action;
	}
}

/**
 * A GameCommand subclass for action phase commands.
 *
 */
class ActionCommand {	
	//TODO extend GameCommand
	
	public String toString(){
		return "Action Command";
	}
}

/**
 * A GameCommand subclass for buy phase commands.
 *
 */
class BuyCommand {
	//TODO extend GameCommand
	
	public String toString(){
		return "Buy Command";
	}
}