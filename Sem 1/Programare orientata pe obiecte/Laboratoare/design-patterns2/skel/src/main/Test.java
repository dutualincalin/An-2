package main;

public class Test {
    public static void main(String[] args) {
        Client client = new Client();

        // Execute various tests

        testDraw(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
        testTextAndColor(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
        testResize(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
        testConnect(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
        testAllCommands(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
        testSimpleUndoRedo(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
        testComplexUndoRedo(client);
        System.out.println(new String(new char[80]).replace("\0", "-"));
    }

    private static void testDraw(Client client) {
        client.newDiagram();

        client.executeAction("draw rectangle");
        client.executeAction("draw rectangle");
        client.executeAction("draw rectangle");
        client.executeAction("draw rectangle");
        client.executeAction("draw rectangle");

        client.showDiagram();
    }

    private static void testTextAndColor(Client client) {
        testDraw(client);
        client.executeAction("change color", "0", "RED");
        client.executeAction("change color", "1", "BLUE");
        client.executeAction("draw rectangle");
        client.executeAction("change text", "0", "MyClass1");
        client.executeAction("change text", "5", "MyClass2");
        client.showDiagram();
    }

    private static void testConnect(Client client) {
        testDraw(client);
        client.executeAction("connect","2","0");
        client.executeAction("connect","2","4");
        client.executeAction("connect","3","5");
        client.showDiagram();
    }

    private static void testResize(Client client) {
        testDraw(client);
        client.executeAction("resize","3", "20");
        client.executeAction("resize","0", "50");
        client.executeAction("resize","4", "120");
        client.executeAction("draw rectangle");
        client.executeAction("resize","5", "100");
        client.showDiagram();
    }

    private static void testAllCommands(Client client) {
        client.newDiagram();
        client.executeAction("draw rectangle");
        client.executeAction("change color", "0", "RED");
        client.executeAction("draw rectangle");
        client.executeAction("connect","1","0");
        client.executeAction("draw rectangle");
        client.executeAction("resize","2", "120");
        client.executeAction("draw rectangle");
        client.executeAction("change text", "3", "Vine vacanta!!!");
        client.showDiagram();
    }

    private static void testSimpleUndoRedo(Client client) {
        client.newDiagram();

        client.executeAction("draw rectangle");
        client.executeAction("change color", "0", "ORANGE");
        client.showDiagram();

        client.executeAction("draw rectangle");
        client.showDiagram();

        client.undo();
        client.showDiagram();

        client.redo();
        client.showDiagram();
    }

    private static void testComplexUndoRedo(Client client) {
        client.newDiagram();
        client.executeAction("draw rectangle");
        client.executeAction("change color", "0", "RED");
        client.showDiagram();
        client.executeAction("draw rectangle");
        client.showDiagram();
        client.undo();
        client.showDiagram();
        client.executeAction("draw rectangle");
        client.redo();
        client.showDiagram();
        client.executeAction("connect","1","0");
        client.executeAction("resize","2", "120");
        client.executeAction("draw rectangle");
        client.executeAction("change text", "3", "Vine vacanta!!!");
        client.showDiagram();
        client.undo();
        client.showDiagram();
        client.redo();
        client.executeAction("change color", "0", "RED");
        client.showDiagram();
    }
}
