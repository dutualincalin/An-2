package card_game;

public class Test {
	
	
	private static void test1(){
		Card c2 = new EstateVictoryCard();
		Card c1 = new MarketActionCard();
		
		//TODO remove comments :)
		//System.out.println(new ActionCommand(c1, GameAction.PLAY));
		//System.out.println(new BuyCommand(c2, GameAction.BUY));
	}
	
	private static void test2(){
		Card c2 = new EstateVictoryCard();
		Card c1 = new MarketActionCard();
		PlayArea playArea = new PlayArea();
		//TODO test the play area - print the given command when play() method is executed
	}
	
	private static void test3_4(){
		PlayArea playArea = new PlayArea();
		ScoreCounter scoreCounter = new ScoreCounter();
		Card c1 = new MarketActionCard();
		Card c2 = new VillageActionCard();
		Card c3 = new GoldTreasureCard();
		Card c4 = new CopperTreasureCard();
		Card c5 = new ProvinceVictoryCard();
		Card c6 = new EstateVictoryCard();		
		
		//TODO remove comments
		
		/*		 
		playArea.addObserver(new GameLogger());
		playArea.addObserver(scoreCounter);
		  
		playArea.setPlayer("alice");
				
		playArea.play(new ActionCommand(c1, GameAction.PLAY));
		playArea.play(new ActionCommand(c2, GameAction.PLAY));
		playArea.play(new ActionCommand(c3, GameAction.PLAY));
		playArea.play(new ActionCommand(c4, GameAction.PLAY));
		playArea.play(new ActionCommand(c4, GameAction.PLAY));
		playArea.play(new BuyCommand(c6, GameAction.BUY));
		
		playArea.setPlayer("bob");
		
		playArea.play(new ActionCommand(c1, GameAction.PLAY));
		playArea.play(new ActionCommand(c2, GameAction.PLAY));
		playArea.play(new ActionCommand(c3, GameAction.PLAY));
		playArea.play(new ActionCommand(c3, GameAction.PLAY));
		playArea.play(new ActionCommand(c4, GameAction.PLAY));
		playArea.play(new ActionCommand(c4, GameAction.PLAY));
		playArea.play(new BuyCommand(c5, GameAction.BUY));
		
		*/
	 
		scoreCounter.printScore();
		
	}
	
	private static void test5(){
		//TODO the same as in test4, but create the actions using CommandFactory	
	}
	
	private static void test6(){
		//TODO the same as in test4, but call undo/redo after some commands	
	}
	
	
	/**
	 * Disclaimer - the game is quite complex and has a lot of other card 
	 * types and rules associated with them, and we don't complicate these
	 * exercises with validity checks (e.g. a player must buy only one card,
	 * a player must have the necessary money to buy a card, some actions 
	 * can't be played after another etc). 
	 */
	
	public static void main(String[]args) {
		
		System.out.println("---------- Ex. 1 ----------");
		test1();
		System.out.println("---------- Ex. 2 ----------");
		test2();
		System.out.println("---------- Ex. 3 & 4 ----------");
		test3_4();
		System.out.println("---------- Ex. 5 ----------");
		test5();
		System.out.println("---------- Ex. 6 ----------");
		test6();	
	}
}
