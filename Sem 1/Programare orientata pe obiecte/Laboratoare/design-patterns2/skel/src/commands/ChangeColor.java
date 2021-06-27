package commands;

import diagram.DiagramComponent;

public class ChangeColor implements DrawCommand{
    private final DiagramComponent diagram;
    private final String oldColor;
    private final String color;

    public ChangeColor(DiagramComponent diagram, String color){
        this.diagram = diagram;
        this.color = color;
        oldColor = diagram.getColor();
    }


    @Override
    public void execute() {
        diagram.setColor(color);
    }

    @Override
    public void undo() {
        diagram.setColor(oldColor);
    }

    @Override
    public String toString() {
        return "ChangeColor{" +
                "diagram=" + diagram +
                ", color='" + color + '\'' +
                '}';
    }
}
