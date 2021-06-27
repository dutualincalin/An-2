package ex2;

/**
 * Interface for objects that need to be observed (monitored).
 *
 */

public interface Observable {
	/**
	 * Register an observer.
	 * @param o the observer
	 */
	void addObserver(ListObserver o);
	/**
	 * Unregister an observer.
	 * @param o the observer
	 */
	void removeObserver(ListObserver o);
}
