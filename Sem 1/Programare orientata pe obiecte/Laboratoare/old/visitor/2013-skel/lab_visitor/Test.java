package lab_visitor;

import java.io.IOException;
import java.nio.file.Files;
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
		Boss ceo	= new Boss("Bob", 1000, 42);
		Boss boss	= new Boss("River", 500, 20);

		boss.addSubordinate(new Employee("Amy", 25));
		boss.addSubordinate(new Employee("Rory", 20));

		ceo.addSubordinate(new Employee("Alice", 22));
		ceo.addSubordinate(boss);

		//TODO compute and print the average income
		//hint: use AverageIncomeVisitor and TreeVisitor
		//hint: ceo is root-node for TreeVisitor
		
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
		Boss ceo	= new Boss("Bob", 1000, 42);
		Boss boss	= new Boss("River", 500, 20);


		boss.addSubordinate(new Employee("Amy", 25));
		boss.addSubordinate(new Employee("Rory", 20));

		ceo.addSubordinate(new Employee("Alice", 22));
		ceo.addSubordinate(boss);

		//TODO add the intern			

		//TODO apply the RevenueVisitor on ceo's subordinates		

		//TODO compute and print the average income
	}

	private static void test4(){

		Path startingDir = Paths.get(".");
		
		DirSizeCounter counter = new DirSizeCounter();
		
		try {
			Files.walkFileTree(startingDir, counter);
			System.out.println(counter.getSize());			
		} catch (IOException e) {			
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {


		System.out.println("---------- Ex. 1 ----------");
		test1();
		System.out.println("---------- Ex. 2 ----------");
		//test2();
		System.out.println("---------- Ex. 3 ----------");
		//test3();
		System.out.println("---------- Ex. 3 ----------");
		//test4();
	}

}
