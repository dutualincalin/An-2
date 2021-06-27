package lab_visitor;

import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;


/**
 * Calculates the total size of visited files.
 *
 */
public class DirSizeCounter extends SimpleFileVisitor<Path> {

	private long size;
	
	//TODO - override visit method(s)	
	
   	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}
}