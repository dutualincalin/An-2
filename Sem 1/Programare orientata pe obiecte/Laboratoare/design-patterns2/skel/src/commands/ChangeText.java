package commands;

import diagram.DiagramComponent;

public class ChangeText implements DrawCommand{
    private final DiagramComponent diagram;
    private final String oldText;
    private final String text;

    public ChangeText(DiagramComponent diagram, String text){
        this.diagram = diagram;
        this.text = text;
        oldText = diagram.getText();
    }


    @Override
    public void execute() {
        diagram.setText(text);
    }

    @Override
    public void undo() {
        diagram.setText(oldText);
    }

    @Override
    public String toString() {
        return "ChangeText{" +
                "diagram=" + diagram +
                ", text='" + text + '\'' +
                '}';
    }
}
