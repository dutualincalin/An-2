package com.oop_pub.clase_interne.Bash;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

enum Commands {
    CD("cd"),
    LS("ls"),
    ECHO("echo"),
    HISTORY("history");

    private final String text;

    Commands(final String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return text;
    }
}

class BashUtils {

    // Implement some inner classes here: Echo, Cd, Ls, History

    // example: class Cd { ... }

    // Decide if they should be static or non-static.

    // TODO 4 Create Echo class

    // TODO 5 Create Cd class

    // TODO 6 Create the Ls class

    // TODO 7 Create the History class

}
