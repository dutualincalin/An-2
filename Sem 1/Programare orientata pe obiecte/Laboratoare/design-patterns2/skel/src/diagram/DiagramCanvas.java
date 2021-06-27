package diagram;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a diagram, it contains various interconnected components.
 *
 * It is the "receiver" of commands.
 */
public class DiagramCanvas {
    private final List<DiagramComponent> components = new ArrayList<>();

    public void addComponent(DiagramComponent diagramComponent) {
        components.add(diagramComponent);
    }

    public void removeComponent(DiagramComponent diagramComponent) {
        components.remove(diagramComponent);
    }

    public DiagramComponent getComponent(int id) {
        return components.get(id);
    }

    public void show() {
        System.out.println("Diagram:");
        components.forEach(System.out::println);
    }
}
