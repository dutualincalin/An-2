package ex1;

/**
 *	Class that represents a person.
 *
 */

public class Person {
	
	// protected not private, because subclasses may need it (any person has a name)
	protected String name;
	
	public Person(){
		name = "";
	}
	
	public Person(String name){
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
