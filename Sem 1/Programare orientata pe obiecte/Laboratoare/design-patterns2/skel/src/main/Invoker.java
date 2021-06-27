package main;

import commands.DrawCommand;

import java.util.LinkedList;

/**
 * The layer between the client and the commands that need to be executed on the receivers (DiagramCanvas and DiagramComponent).
 * <br>
 * It is independent of the subtypes of commands, it just receives a command, runs it and implements a redo/undo mechanism.
 */
public class Invoker {
    LinkedList<DrawCommand> done = new LinkedList<>();
    LinkedList<DrawCommand> undone = new LinkedList<>();
    /**
     * Clear up all the used resources, start fresh :D
     */
    public void restart() {
        done.clear();
        undone.clear();
    }

    /**
     * Executes a given command
     * @param command The command
     */
    public void execute(DrawCommand command) {
        command.execute();
        done.add(command);
    }

    /**
     * Undo the latest command
     */
    public void undo() {
        if (done.size() > 0) {
            DrawCommand command = done.pop();
            command.undo();
            undone.add(command);
        }
    }

    /**
     * Redo command previously undone. Cannot perform a redo after an execute, only after at least one undo.
     */
    public void redo() {
        if (undone.size() > 0) {
            DrawCommand command = undone.pop();
            command.execute();
            done.add(command);
        }
    }
}
