package lab_visitor;
import java.util.LinkedList;

public interface Visitable {
	public void accept(Visitor v);
}

class Employee implements Visitable{
	protected String  name;
	protected float salary;        
	public Employee(String name, float salary) {
		this.name       = name;
		this.salary     = salary;
	}
	public String getName() {
		return name;
	}
	public float getSalary() {
		return salary;
	} 
	@Override
	public void accept(Visitor v) {
		v.visit(this);  
	}
}

class Boss extends Employee {        
	protected float bonus;

	public LinkedList<Visitable> getSubordinates() {
		//TODO
		return null;
	}
	public void addSubordinate(Visitable subordinate) {
		//TODO
	}

	public Boss(String name, float salary, float bonus) {
		super(name, salary);
		this.bonus = bonus;
	}
	public float getBonus() {
		return bonus;
	}
	public void setBonus(float bonus) {
		this.bonus = bonus;
	}

	
	/*	Ex 1. The purpose of the task is just a reminder of what happens at 
		runtime and what happens at compile time: If accept in Boss is not 
		overridden then the element passed to the visit method is of type 
		Employee not Boss. At compile-time, in accept method from Employee the 
		type of the parameter of the v.visit() call is Employee, and since
		overloaded methods are decided at compile-time, the call will be
		visit(Employee).
	*/
	@Override
	public void accept(Visitor v) {
		v.visit(this);  
	}
}

//TODO
class Intern{

	private String  name;
	private int duration;  // in months

	public Intern(String name, int duration){
		this.name = name;
		this.duration = duration;
	}


}
