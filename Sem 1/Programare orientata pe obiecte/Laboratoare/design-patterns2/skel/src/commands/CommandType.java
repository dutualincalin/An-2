package commands;

/**
 * Supported commands
 */
public enum CommandType {
    DRAW_RECTANGLE("draw rectangle"),
    CHANGE_COLOR("change color"),
    RESIZE("resize"),
    CONNECT("connect"),
    CHANGE_TEXT("change text");

    public final String text;

    CommandType(String text) {
        this.text = text;
    }

    public static CommandType fromString(String text) {
        for (CommandType commandType : CommandType.values()) {
            if (commandType.text.equalsIgnoreCase(text)) {
                return commandType;
            }
        }
        return null;
    }
}
