package lab_visitor;
public interface Visitor {
	public void visit(Employee e);
	public void visit(Boss b);
}

/**
 * Visitor for printing an employee's data. Applies the operation only on objects
 * that implement Visitable, currently Employee and Boss.
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
 * Visitor for computing the average salary in a company.
 */

class AverageIncomeVisitor implements Visitor {
	int incomeSum, bonuses;
	int numEmployees;

	public void visit(Employee e) {
		//TODO
	}
	
	public void visit(Boss b) {
		//TODO
	}

	/**
	 * Computes the average salary and bonus wages (if specified).
	 * @param withBonus - true - if the average contains also the bonus wages
	 * @return the average income
	 */
	public float getAverageIncome(Boolean withBonus){
		//TODO
		
		return 0f;
	}	
}


/**
 * Visitor for tree traversal - separate the concerns: a visitor for data
 * operations (e.g. compute average percentage) and this visitor for traversing the nodes
 * and applying the operation visitor.
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