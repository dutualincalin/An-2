package ex2;

/**
 * Interface for objects that monitor lists' changes.
 *
 */
public interface ListObserver {
	
	/**
	 * Receives a notification of an event. 
	 * @param e
	 */
	void notifyEvent(ListEvent e);	
}