package game;

public interface Command {
    public abstract void undo();
    public abstract void execute();
}
