package game;

import java.util.Scanner;

public class Main {

	public static GameState gs = new GameState();

	private static String helpMessage() {

		String s ="Commands:\n" 
				+ "\t start - starts an adventure, must be called after adding heroes\n"
				+ "\t add <hero-type> <hero-name>\n"
				+ "\t\t hero types: warrior, mage, priest (any case)\n"
				+ "\t move <hero-name> <direction>\n"
				+ "\t\t directions: right, left, up, down\n"
				+ "\t stop - ends the program"
				+ "\t help - prints this menu";

		return s;
	}
	

	public static void main(String [] args) {

		while(true) {
			System.out.println(">");
			Scanner sc = new Scanner(System.in);
			String cmd = sc.nextLine();
			String []cmdTokens = cmd.split(" ");

			switch(cmdTokens[0]) {
			
			case "help":
				System.out.println(Main.helpMessage());
				break;
			
			case "add":
				if (gs.isAdventureStarted()) {
					System.out.println("Adventure has already started..."
										+ "maybe next time!\n");
					break;
				}
				
				if (cmdTokens.length < 3) {
					System.out.println("Not enough parameters..!\n"
										+ Main.helpMessage());
					break;
				}
				
				System.out.println("Adding " + cmdTokens[1] 
						+ " named " + cmdTokens[2]
								+ " to the party.");

				// check the hero's type and create the hero

				HeroType heroType;

				try {
					heroType = HeroType.valueOf(cmdTokens[1].toUpperCase());
					// TODO create the hero and add it to the party
					System.out.println("Party :" + gs.getParty());
				} catch (IllegalArgumentException ex) {
					System.out.println("Wrong hero type! Try again...\n"
							+"Possible hero types: warrior, mage, priest (any case)");
				}		
				
				break;
						

			case "start":
				
				if (!gs.isAdventureStarted()) {
					System.out.println("We're off on an adventure!");
					gs.setAdventureStarted(true);
					gs.populateTreasures(5);
					
					//TODO Add observers to the GameState
					//TODO The game state must inform its observers
					
				}
				break;
				
			case "move":
				
				if (gs.isAdventureStarted()) {

					if (cmdTokens.length < 3) {
						System.out.println("Not enough parameters..!\n"
											+ Main.helpMessage());
						break;
					}
					
					Direction dir = null;
					
					switch(cmdTokens[2]) {					
					case "right": dir = Direction.E; break;
					case "left": dir = Direction.W; break;
					case "up": dir = Direction.N; break;
					case "down": dir = Direction.S; break;
					default: System.out.println("Wrong direction! Try again...");
					}

					for (Hero h : gs.getParty())	    			
						if (h.getName().equals(cmdTokens[1])) {							
							h.move(dir);	
							System.out.println("Found hero " + h.getName());
						}
				}
				
				else {
					System.out.println("First start the adventure, than move the heroes!");
				}
				
				break;
				
			case "stop":
				if (gs.isAdventureStarted()) {
					System.out.println("Adventure ended");
				}
				
				sc.close();
				
				System.exit(0);
			
			default: System.out.println("try again...\n" + Main.helpMessage());
			}
		}		
	}
}

