package lab_visitor;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.LinkedList;

public class Test {

	private static void test1() {
		
		List<Employee> employees = new LinkedList<Employee>();
		employees.add(new Employee("Alice", 20));
		employees.add(new Employee("Trudy", 50));
		employees.add(new Boss("Bob", 1000, 42));
		
		Visitor v = new RevenueVisitor();
		for (Employee e : employees)
			e.accept(v);
	}

	private static void test2() {
		/*
		 * Bob
		 *   - Alice
		 *   - River
		 *   	- Amy
		 *   	- Rory
		 */
		Boss ceo	= new Boss("Bob", 1000, 2, 42);
		Boss boss	= new Boss("River", 500, 7, 20);
		
		boss.addSubordinate(new Employee("Amy", 250, 10));
		boss.addSubordinate(new Employee("Rory", 200, 5));

		ceo.addSubordinate(new Employee("Alice", 220, 0));
		ceo.addSubordinate(boss);
	
		MostHardworkingEmployeeFinder extraHoursVisitor = 
											new MostHardworkingEmployeeFinder();
		//TODO use MostHardworkingEmployeeFinder and TreeVisitor
		//hint: ceo is root-node for TreeVisitor
		
		 
		System.out.format("The %s are are the most hardworking\n",
			extraHoursVisitor.isBossHardWorking() ? "bosses " : "employees");
		
		//TODO try also other values for extraHours for the objects declared 
		//above
	}
	
	private static void test3() {
		/*
		 * Bob
		 *   - Alice
		 *   - River
		 *   	- Amy
		 *   	- Rory
		 *   - LowlyIntern
		 */
		Boss ceo	= new Boss("Bob", 1000, 2, 42);
		Boss boss	= new Boss("River", 500, 7, 20);
		
		boss.addSubordinate(new Employee("Amy", 250, 10));
		boss.addSubordinate(new Employee("Rory", 200, 5));

		ceo.addSubordinate(new Employee("Alice", 220, 0));
		ceo.addSubordinate(boss);
		
		//TODO add an intern
		//TODO apply the RevenueVisitor on ceo's subordinates	
		
		MostHardworkingEmployeeFinder extraHoursVisitor = 
											new MostHardworkingEmployeeFinder();
		//TODO use MostHardworkingEmployeeFinder and TreeVisitor
		//hint: ceo is root-node for TreeVisitor
		
		System.out.format("The %s are the most hardworking\n",
			extraHoursVisitor.isBossHardWorking() ? "bosses " : "employees");
	}

	private static void test4(){
		
		Path startingDir = Paths.get(".");
		FilesCounter counter = new FilesCounter();
		
		//TODO 
		// use Files.walkFileTree
		// get the list of files and  print its size and their paths		
	}
	
	public static void main(String[] args) {

		System.out.println("---------- Ex. 1 ----------");
		//test1();
		System.out.println("---------- Ex. 2 ----------");
		//test2();
		System.out.println("---------- Ex. 3 ----------");
		//test3();
		System.out.println("---------- Ex. 4 ----------");
		//test4(); 
	}

}
