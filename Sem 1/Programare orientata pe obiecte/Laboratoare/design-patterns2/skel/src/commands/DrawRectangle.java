package commands;

import diagram.DiagramCanvas;
import diagram.DiagramComponent;

public class DrawRectangle implements DrawCommand{
    private final DiagramCanvas canvas;
    private final DiagramComponent diagram;

    public DrawRectangle(DiagramCanvas canvas){
        this.canvas = canvas;
        diagram  = new DiagramComponent();
    }

    @Override
    public void execute(){
        canvas.addComponent(diagram);
    }

    @Override
    public void undo(){
        canvas.removeComponent(diagram);
    }

    @Override
    public String toString() {
        return "DrawRectangle{" +
                "canvas=" + canvas +
                '}';
    }
}
