package lab_visitor;

import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.util.ArrayList;

/**
 * Stores the paths of all the Java files in a given directory. 
 */
public class FilesCounter extends SimpleFileVisitor<Path> {

	private ArrayList<Path> javaFiles;
	
    public ArrayList<Path> getJavaFiles() {
		return javaFiles;
	}
    
    //TODO - override visit method(s)
}