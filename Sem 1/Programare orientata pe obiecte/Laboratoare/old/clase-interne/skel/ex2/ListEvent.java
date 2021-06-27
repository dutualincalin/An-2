package ex2;


/**
 * Abstract class for list related events. 
 *
 */

public abstract class ListEvent {

	private EventType type;
	

	public ListEvent(EventType type){
		this.type = type;
	}
	
	/**
	 * Provides the list on which the event happened.
	 * 
	 * @return the list
	 */

	@SuppressWarnings("rawtypes")  // because we haven't done the Generics lab yet 
								   // it should have been MyArrayList<E> and ListEvent<E>
	public abstract MyArrayList getList();
	
	/**
	 * Provides the list element involve in the event.
	 * 
	 * @return
	 */
	public abstract Object getElement();
	
	/**
	 * Provides the duration of the event. 
	 * 
	 * @return the number of nanoseconds
	 */
	public abstract long getDuration();
	
	public EventType getType() {
		return type;
	}
	public void setType(EventType type) {
		this.type = type;
	}
	
	
}

enum EventType {
	ADD, REMOVE, SET
}

