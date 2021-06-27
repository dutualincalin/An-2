package commands;

import diagram.DiagramComponent;

public class ConnectComponents implements DrawCommand{
    DiagramComponent diagram1;
    String id;

    public ConnectComponents(DiagramComponent diagram1, String id2){
        this.diagram1 = diagram1;
        id = id2;
    }


    @Override
    public void execute() {
        diagram1.connectTo(id);
    }

    @Override
    public void undo() {
        diagram1.removeConnection(id);
    }

    @Override
    public String toString() {
        return "ConnectComponents{" +
                "diagram1=" + diagram1 +
                ", id='" + id + '\'' +
                '}';
    }
}
