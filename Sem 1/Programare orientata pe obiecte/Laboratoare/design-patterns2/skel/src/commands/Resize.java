package commands;

import diagram.DiagramComponent;

public class Resize implements DrawCommand{
    private final DiagramComponent diagram;
    private final int oldHeight;
    private final int oldWeight;
    int percent;

    public Resize(DiagramComponent diagram, int percent){
        this.diagram = diagram;
        this.percent = percent;
        oldHeight = diagram.getHeight();
        oldWeight = diagram.getWeight();
    }

    @Override
    public void execute() {
        diagram.setHeight(percent* diagram.getHeight() / 100);
        diagram.setWeight(percent* diagram.getWeight() / 100);
    }

    @Override
    public void undo() {
        diagram.setHeight(oldHeight);
        diagram.setWeight(oldWeight);
    }
}
