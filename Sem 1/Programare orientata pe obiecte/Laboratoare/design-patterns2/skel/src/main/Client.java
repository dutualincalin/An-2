package main;

import commands.*;
import diagram.DiagramCanvas;

/**
 * Receives commands in clear text from the user and transforms them in DrawCommand objects. It uses the Invoker to
 * execute the given commands.
 */
public class Client {

    private final Invoker invoker;
    private DiagramCanvas diagramCanvas;

    Client() {
        invoker = new Invoker();
        diagramCanvas = new DiagramCanvas();
    }

    public void showDiagram() {
        System.out.println();
        diagramCanvas.show();
    }

    public void newDiagram() {
        diagramCanvas = new DiagramCanvas();
        invoker.restart();
    }

    public void executeAction(String commandName, String ...args) {

        DrawCommand command;
        try {
            CommandType commandType = CommandType.fromString(commandName);
            command = getCommand(commandType, args);
            if (command == null) {
                throw new IllegalArgumentException();
            }

        } catch(IllegalArgumentException ex) {
            System.out.println("Invalid command: " + commandName);
            System.out.println("Available commands:");
            for (CommandType type : CommandType.values()) {
                System.out.println("\t- " + type.text);
            }
            return;
        }

        invoker.execute(command);

    }

    private DrawCommand getCommand(CommandType type, String ...args) throws IllegalArgumentException {
        return switch (type) {
            case DRAW_RECTANGLE -> new DrawRectangle(diagramCanvas);
            case RESIZE -> new Resize(diagramCanvas.getComponent(Integer.parseInt(args[0])),
                    Integer.parseInt(args[1]));
            case CONNECT -> new ConnectComponents(
                    diagramCanvas.getComponent(Integer.parseInt(args[0])), args[1]);
            case CHANGE_TEXT -> new ChangeText(
                    diagramCanvas.getComponent(Integer.parseInt(args[0])), args[1]);
            case CHANGE_COLOR -> new ChangeColor(
                    diagramCanvas.getComponent(Integer.parseInt(args[0])), args[1]);
        };
    }

    public void undo(){
        invoker.undo();
    }

    public void redo() {
        invoker.redo();
    }
}
