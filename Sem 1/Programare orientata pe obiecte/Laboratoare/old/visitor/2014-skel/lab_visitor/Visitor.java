package lab_visitor;

public interface Visitor {
	public void visit(Employee e);
	public void visit(Boss b);	
}

/**
 * Visitor for printing an employee's data. Applies the operation only on objects
 * that implement Visitable, currently Employee and Boss.
 *
 */
class RevenueVisitor implements Visitor { 
	@Override
	public void visit(Employee e) {
		System.out.println(e.getName() + " " + e.getSalary());
	}  
	@Override
	public void visit(Boss b) {
		System.out.println(b.getName() + " " + (b.getSalary() + b.getBonus()));
	}
}

/**
 * Visitor for finding if the average number of extra hours for bosses is higher
 * than the one for employees.
 * 
 * Interns are not taken into consideration.
 */

class MostHardworkingEmployeeFinder implements Visitor {
	
	@Override
	public void visit(Employee e) {
		//TODO
	}

	@Override
	public void visit(Boss b) {
		//TODO
	}
	
	public boolean isBossHardWorking() {
		//TODO
		
		return false;
	}	
}


/**
 * Visitor for tree traversal - separate the concerns: a visitor for data
 * operations (e.g. compute average percentage) and this visitor for traversing
 * the nodes and applying the operation visitor.
 */

class TreeVisitor implements Visitor {

	private Visitor baseVisitor;

	public TreeVisitor(Visitor baseVisitor) {
		this.baseVisitor = baseVisitor;
	}

	@Override
	public void visit(Employee e) {
		//TODO
	}

	@Override
	public void visit(Boss b) {
		//TODO
	
	}

	public Visitor getBaseVisitor() {
		return baseVisitor;
	}
}