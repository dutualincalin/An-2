package com.poo.lab12;

import com.poo.lab12.entities.*;
import com.poo.lab12.reports.BankReport;
import com.poo.lab12.reports.BusinessReport;
import com.poo.lab12.exceptions.ExistsException;

public class Main {
    private static Bank bank;
    private static Business business1;
    private static Business business2;
    
    public static void main(String[] args) {
		bank = new Bank();
		business1 = new Business();
		business2 = new Business();

		try {
			modifyBank();

			printBankReport();

			printBusinessReport();
		} catch(Exception e) {
			e.printStackTrace();
		}
    }

    private static void modifyBank() throws ExistsException {
		// Businesses
		bank.addClient(business1);
		bank.addClient(business2);

		// Employees
		Employee e1 = new Employee("Rajesh", 29, "Jaipur", Gender.MALE, Disability.DISABLED, Religion.BUDDHISM);
		Employee e2 = new Employee("Abdul", 22, "Mumbai", Gender.MALE, Disability.HEALTHY, Religion.BUDDHISM);
		Employee e3 = new Employee("Arjun", 20, "Ahmedabad", Gender.FEMALE, Disability.HEALTHY, Religion.BUDDHISM);
		Employee e4 = new Employee("Brijesh", 39, "Mumbai", Gender.MALE, Disability.DISABLED, Religion.BUDDHISM);
		Employee e5 = new Employee("Darsh", 49, "Delhi", Gender.MALE, Disability.DISABLED, Religion.CRISTIANITY);
		Employee e6 = new Employee("Ekaraj", 32, "Mumbai", Gender.FEMALE, Disability.HEALTHY, Religion.CRISTIANITY);
		Employee e7 = new Employee("Fariq", 25, "Delhi", Gender.MALE, Disability.DISABLED, Religion.CRISTIANITY);
		Employee e8 = new Employee("Girik", 50, "Delhi", Gender.FEMALE, Disability.HEALTHY, Religion.CRISTIANITY);
		Employee e9 = new Employee("Gunbir", 56, "Jaipur", Gender.FEMALE, Disability.DISABLED, Religion.CRISTIANITY);
		Employee e10 = new Employee("Hitesh", 23, "Mumbai", Gender.MALE, Disability.HEALTHY, Religion.CALVINISM);
		Employee e11 = new Employee("Jagdish", 46, "Bangalore", Gender.MALE, Disability.HEALTHY, Religion.CALVINISM);
		Employee e12 = new Employee("Jairaj", 58, "Mumbai", Gender.FEMALE, Disability.DISABLED, Religion.DAOISM);
		Employee e13 = new Employee("Kabir", 42, "Delhi", Gender.MALE, Disability.HEALTHY, Religion.DAOISM);
		Employee e14 = new Employee("Krishna", 34, "Ahmedabad", Gender.FEMALE, Disability.DISABLED, Religion.DAOISM);
		Employee e15 = new Employee("Mitesh", 18, "Mumbai", Gender.MALE, Disability.ANONIMOUS, Religion.HINDUISM);
		Employee e16 = new Employee("Naveen", 27, "Bangalore", Gender.FEMALE, Disability.HEALTHY, Religion.HINDUISM);
		Employee e17 = new Employee("Onkar", 37, "Ahmedabad", Gender.FEMALE, Disability.ANONIMOUS, Religion.ISLAM);
		Employee e18 = new Employee("Praneel", 49, "Bangalore", Gender.MALE, Disability.ANONIMOUS, Religion.ISLAM);
		Employee e19 = new Employee("Ranveer", 52, "Mumbai", Gender.MALE, Disability.DISABLED, Religion.ISLAM);

		// Projects
		Project p1 = new Project("Bender Project", 6);
		Project p2 = new Project("Hornets", 10);
		Project p3 = new Project("Westerners", 12);
		Project p4 = new Project("Whistler", 24);
		Project p5 = new Project("Coding Region", 3);
		Project p6 = new Project("The Blue Bird", 7);
		Project p7 = new Project("Fast Ball", 14);
		Project p8 = new Project("Mercury", 60);
		Project p9 = new Project("Limitless Horizons", 8);
		Project p10 = new Project("Strive Training", 8);
		Project p11 = new Project("Yaeger", 8);
		Project p12 = new Project("Yoda", 20);
		Project p13 = new Project("Meetup for the God", 26);
		Project p14 = new Project("Next Gala", 36);
		Project p15 = new Project("Sirius", 6);
		Project p16 = new Project("Sputnik", 6);
		Project p17 = new Project("Stratos", 8);
		Project p18 = new Project("Revolution", 10);
		Project p19 = new Project("Red Butter", 3);
		Project p20 = new Project("Rhinestone", 7);
		Project p21 = new Project("Linkage", 14);
		Project p22 = new Project("Excalibur", 6);
		Project p23 = new Project("Wombat", 6);
		Project p24 = new Project("Indie", 12);
		Project p25 = new Project("The Art of Codes", 26);
		Project p26 = new Project("Annual Award Show", 36);
		Project p27 = new Project("Robust Routine", 6);
		Project p28 = new Project("Wide Stringer", 6);
		Project p29 = new Project("Static Startup", 6);

		// Accounts
		Account a1 = new Account(1, 200, 10);
		Account a2 = new Account(2, 900, 10);
		Account a3 = new Account(3, 900, 10);
		Account a4 = new Account(4, 1600, 10);
		Account a5 = new Account(5, 1600, 10);
		Account a6 = new Account(6, 1600, 10);
		Account a7 = new Account(7, 2000, 10);
		Account a8 = new Account(8, 2000, 10);
		Account a9 = new Account(9, 2000, 10);
		Account a10 = new Account(10, 3000, 20);
		Account a11 = new Account(11, 4000, 20);
		Account a12 = new Account(12, 4000, 20);
		Account a13 = new Account(13, 4000, 20);
		Account a14 = new Account(14, 5000, 20);
		Account a15 = new Account(15, 5000, 20);
		Account a16 = new Account(16, 5000, 20);
		Account a17 = new Account(17, 7000, 30);
		Account a18 = new Account(18, 7000, 30);
		Account a19 = new Account(19, 9000, 30);
		Account a20 = new Account(20, 9000, 30);
		Account a21 = new Account(21, 9000, 30);
		Account a22 = new Account(22, 9400, 30);
		Account a23 = new Account(23, 9400, 30);
		Account a24 = new Account(24, 9400, 50);
		Account a25 = new Account(25, 9400, 50);
		Account a26 = new Account(26, 9400, 50);
		Account a27 = new Account(27, 10000, 50);
		Account a28 = new Account(28, 20000, 100);
		Account a29 = new Account(29, 20500, 100);
		Account a30 = new Account(30, 30000, 300);

		// Pair employees - accounts
		e1.addAccount(a1);
		e2.addAccount(a2);
		e3.addAccount(a3);
		e4.addAccount(a4);
		e5.addAccount(a5);
		e6.addAccount(a6);
		e7.addAccount(a7);
		e8.addAccount(a8);
		e9.addAccount(a9);
		e10.addAccount(a10);
		e11.addAccount(a11);
		e12.addAccount(a12);
		e13.addAccount(a13);
		e14.addAccount(a14);
		e15.addAccount(a15);
		e16.addAccount(a16);
		e17.addAccount(a17);
		e18.addAccount(a18);
		e19.addAccount(a19);
		e10.addAccount(a20);
		e1.addAccount(a21);
		e12.addAccount(a22);
		e3.addAccount(a23);
		e4.addAccount(a24);
		e15.addAccount(a25);
		e6.addAccount(a26);
		e7.addAccount(a27);
		e8.addAccount(a28);
		e19.addAccount(a29);
		e10.addAccount(a30);

		// Pair employees - projects
		e1.addProject(p1);
		e2.addProject(p2);
		e3.addProject(p3);
		e4.addProject(p4);
		e5.addProject(p5);
		e6.addProject(p6);
		e7.addProject(p7);
		e8.addProject(p8);
		e9.addProject(p9);
		e10.addProject(p10);
		e11.addProject(p11);
		e12.addProject(p12);
		e13.addProject(p13);
		e14.addProject(p14);
		e15.addProject(p15);
		e16.addProject(p16);
		e17.addProject(p17);
		e18.addProject(p18);
		e19.addProject(p19);
		e10.addProject(p20);
		e1.addProject(p21);
		e12.addProject(p22);
		e3.addProject(p23);
		e4.addProject(p24);
		e15.addProject(p25);
		e6.addProject(p26);
		e7.addProject(p27);
		e8.addProject(p28);
		e19.addProject(p29);
		e10.addProject(p29);
		e10.addProject(p10);
		e11.addProject(p11);
		e12.addProject(p2);
		e13.addProject(p3);
		e14.addProject(p4);
		e15.addProject(p5);
		e16.addProject(p6);
		e17.addProject(p7);
		e18.addProject(p8);
		e19.addProject(p9);
		e10.addProject(p20);
		e1.addProject(p21);
		e12.addProject(p22);
		e3.addProject(p13);
		e4.addProject(p14);
		e15.addProject(p15);
		e6.addProject(p16);
		e7.addProject(p17);
		e8.addProject(p18);
		e19.addProject(p19);
		e10.addProject(p20);
		e1.addProject(p11);
		e2.addProject(p21);
		e3.addProject(p13);
		e4.addProject(p14);
		e5.addProject(p15);
		e6.addProject(p16);
		e7.addProject(p17);
		e8.addProject(p18);
		e9.addProject(p19);
		e10.addProject(p12);
		e11.addProject(p12);
		e12.addProject(p17);
		e13.addProject(p12);
		e14.addProject(p12);
		e15.addProject(p12);
		e16.addProject(p12);
		e17.addProject(p12);
		e18.addProject(p12);
		e19.addProject(p12);
		e10.addProject(p2);
		e1.addProject(p14);
		e12.addProject(p26);

		// Pair Businesses - projects
		business1.addProject(p1);
		business1.addProject(p2);
		business1.addProject(p3);
		business1.addProject(p4);
		business1.addProject(p5);
		business1.addProject(p6);
		business1.addProject(p7);
		business1.addProject(p8);
		business1.addProject(p9);
		business1.addProject(p10);
		business1.addProject(p11);
		business1.addProject(p12);
		business1.addProject(p13);
		business1.addProject(p14);
		business1.addProject(p15);
		business1.addProject(p16);
		business1.addProject(p17);
		business1.addProject(p18);
		business2.addProject(p19);
		business2.addProject(p20);
		business2.addProject(p21);
		business2.addProject(p22);
		business2.addProject(p23);
		business2.addProject(p24);
		business2.addProject(p25);
		business2.addProject(p26);
		business2.addProject(p27);
		business2.addProject(p28);
		business2.addProject(p29);

		// Pair Businesses - employees
		business1.addEmployee(e1);
		business1.addEmployee(e2);
		business1.addEmployee(e3);
		business1.addEmployee(e4);
		business1.addEmployee(e5);
		business1.addEmployee(e6);
		business1.addEmployee(e7);
		business1.addEmployee(e8);
		business1.addEmployee(e9);
		business1.addEmployee(e10);
		business1.addEmployee(e11);
		business1.addEmployee(e12);
		business2.addEmployee(e13);
		business2.addEmployee(e14);
		business2.addEmployee(e15);
		business2.addEmployee(e16);
		business2.addEmployee(e17);
		business2.addEmployee(e18);
		business2.addEmployee(e19);
    }

    private static void printBankReport() {
        System.out.println("---------------- getNumberOfCustomers test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getNumberOfCustomers(bank));
		// 19

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getNumberOfAccounts test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getNumberOfAccounts(bank));
		// 30

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getCustomersSorted test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getCustomersSorted(bank));
//		 [Name Abdul, city Mumbai, age 22, gender MALE
//		 , Name Arjun, city Ahmedabad, age 20, gender FEMALE
//		 , Name Brijesh, city Mumbai, age 39, gender MALE
//		 , Name Darsh, city Delhi, age 49, gender MALE
//		 , Name Ekaraj, city Mumbai, age 32, gender FEMALE
//		 , Name Fariq, city Delhi, age 25, gender MALE
//		 , Name Girik, city Delhi, age 50, gender FEMALE
//		 , Name Gunbir, city Jaipur, age 56, gender FEMALE
//		 , Name Hitesh, city Mumbai, age 23, gender MALE
//		 , Name Jagdish, city Bangalore, age 46, gender MALE
//		 , Name Jairaj, city Mumbai, age 58, gender FEMALE
//		 , Name Kabir, city Delhi, age 42, gender MALE
//		 , Name Krishna, city Ahmedabad, age 34, gender FEMALE
//		 , Name Mitesh, city Mumbai, age 18, gender MALE
//		 , Name Naveen, city Bangalore, age 27, gender FEMALE
//		 , Name Onkar, city Ahmedabad, age 37, gender FEMALE
//		 , Name Praneel, city Bangalore, age 49, gender MALE
//		 , Name Rajesh, city Jaipur, age 29, gender MALE
//		 , Name Ranveer, city Mumbai, age 52, gender MALE
//		 ]


		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getTotalSumInAccounts test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getTotalSumInAccounts(bank));
		// 211300.0

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getAccountsSortedBySum test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getAccountsSortedBySum(bank));
		// [Account{id=1, balance=200.0, maximumAmountToWithdraw=10.0}
		// , Account{id=2, balance=900.0, maximumAmountToWithdraw=10.0}
		// , Account{id=3, balance=900.0, maximumAmountToWithdraw=10.0}
		// , Account{id=4, balance=1600.0, maximumAmountToWithdraw=10.0}
		// , Account{id=5, balance=1600.0, maximumAmountToWithdraw=10.0}
		// , Account{id=6, balance=1600.0, maximumAmountToWithdraw=10.0}
		// , Account{id=7, balance=2000.0, maximumAmountToWithdraw=10.0}
		// , Account{id=8, balance=2000.0, maximumAmountToWithdraw=10.0}
		// , Account{id=9, balance=2000.0, maximumAmountToWithdraw=10.0}
		// , Account{id=10, balance=3000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=11, balance=4000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=12, balance=4000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=13, balance=4000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=14, balance=5000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=15, balance=5000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=16, balance=5000.0, maximumAmountToWithdraw=20.0}
		// , Account{id=17, balance=7000.0, maximumAmountToWithdraw=30.0}
		// , Account{id=18, balance=7000.0, maximumAmountToWithdraw=30.0}
		// , Account{id=19, balance=9000.0, maximumAmountToWithdraw=30.0}
		// , Account{id=20, balance=9000.0, maximumAmountToWithdraw=30.0}
		// , Account{id=21, balance=9000.0, maximumAmountToWithdraw=30.0}
		// , Account{id=22, balance=9400.0, maximumAmountToWithdraw=30.0}
		// , Account{id=23, balance=9400.0, maximumAmountToWithdraw=30.0}
		// , Account{id=24, balance=9400.0, maximumAmountToWithdraw=50.0}
		// , Account{id=25, balance=9400.0, maximumAmountToWithdraw=50.0}
		// , Account{id=26, balance=9400.0, maximumAmountToWithdraw=50.0}
		// , Account{id=27, balance=10000.0, maximumAmountToWithdraw=50.0}
		// , Account{id=28, balance=20000.0, maximumAmountToWithdraw=100.0}
		// , Account{id=29, balance=20500.0, maximumAmountToWithdraw=100.0}
		// , Account{id=30, balance=30000.0, maximumAmountToWithdraw=300.0}
		// ]

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getCustomerAccounts test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getCustomerAccounts(bank));
//		 {Name Gunbir, city Jaipur, age 56, gender FEMALE
//		 	=[Account{id=9, balance=2000.0, maximumAmountToWithdraw=10.0}
//		 	], Name Mitesh, city Mumbai, age 18, gender MALE
//		 	=[Account{id=25, balance=9400.0, maximumAmountToWithdraw=50.0}
//		 	, Account{id=15, balance=5000.0, maximumAmountToWithdraw=20.0}
//		 	], Name Jagdish, city Bangalore, age 46, gender MALE
//		 	=[Account{id=11, balance=4000.0, maximumAmountToWithdraw=20.0}
//		 	], Name Kabir, city Delhi, age 42, gender MALE
//		 	=[Account{id=13, balance=4000.0, maximumAmountToWithdraw=20.0}
//		 	], Name Darsh, city Delhi, age 49, gender MALE
//		 	=[Account{id=5, balance=1600.0, maximumAmountToWithdraw=10.0}
//		 	], Name Naveen, city Bangalore, age 27, gender FEMALE
//		 	=[Account{id=16, balance=5000.0, maximumAmountToWithdraw=20.0}
//		 	], Name Ranveer, city Mumbai, age 52, gender MALE
//		 	=[Account{id=29, balance=20500.0, maximumAmountToWithdraw=100.0}
//		 	, Account{id=19, balance=9000.0, maximumAmountToWithdraw=30.0}
//		 	], Name Ekaraj, city Mumbai, age 32, gender FEMALE
//		 	=[Account{id=26, balance=9400.0, maximumAmountToWithdraw=50.0}
//		 	, Account{id=6, balance=1600.0, maximumAmountToWithdraw=10.0}
//		 	], Name Rajesh, city Jaipur, age 29, gender MALE
//		 	=[Account{id=1, balance=200.0, maximumAmountToWithdraw=10.0}
//		 	, Account{id=21, balance=9000.0, maximumAmountToWithdraw=30.0}
//		 	], Name Girik, city Delhi, age 50, gender FEMALE
//		 	=[Account{id=8, balance=2000.0, maximumAmountToWithdraw=10.0}
//		 	, Account{id=28, balance=20000.0, maximumAmountToWithdraw=100.0}
//		 	], Name Brijesh, city Mumbai, age 39, gender MALE
//		 	=[Account{id=24, balance=9400.0, maximumAmountToWithdraw=50.0}
//		 	, Account{id=4, balance=1600.0, maximumAmountToWithdraw=10.0}
//		 	], Name Onkar, city Ahmedabad, age 37, gender FEMALE
//		 	=[Account{id=17, balance=7000.0, maximumAmountToWithdraw=30.0}
//		 	], Name Arjun, city Ahmedabad, age 20, gender FEMALE
//		 	=[Account{id=23, balance=9400.0, maximumAmountToWithdraw=30.0}
//		 	, Account{id=3, balance=900.0, maximumAmountToWithdraw=10.0}
//		 	], Name Abdul, city Mumbai, age 22, gender MALE
//		 	=[Account{id=2, balance=900.0, maximumAmountToWithdraw=10.0}
//		 	], Name Fariq, city Delhi, age 25, gender MALE
//		 	=[Account{id=7, balance=2000.0, maximumAmountToWithdraw=10.0}
//		 	, Account{id=27, balance=10000.0, maximumAmountToWithdraw=50.0}
//		 	], Name Jairaj, city Mumbai, age 58, gender FEMALE
//		 	=[Account{id=22, balance=9400.0, maximumAmountToWithdraw=30.0}
//		 	, Account{id=12, balance=4000.0, maximumAmountToWithdraw=20.0}
//		 	], Name Hitesh, city Mumbai, age 23, gender MALE
//		 	=[Account{id=10, balance=3000.0, maximumAmountToWithdraw=20.0}
//		 	, Account{id=30, balance=30000.0, maximumAmountToWithdraw=300.0}
//		 	, Account{id=20, balance=9000.0, maximumAmountToWithdraw=30.0}
//		 	], Name Krishna, city Ahmedabad, age 34, gender FEMALE
//		 	=[Account{id=14, balance=5000.0, maximumAmountToWithdraw=20.0}
//		 	], Name Praneel, city Bangalore, age 49, gender MALE
//		 	=[Account{id=18, balance=7000.0, maximumAmountToWithdraw=30.0}
//		 	]}

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getCustomersByCity test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getCustomersByCity(bank));
//		 {Ahmedabad=[Name Arjun, city Ahmedabad, age 20, gender FEMALE
//		 	, Name Onkar, city Ahmedabad, age 37, gender FEMALE
//		 	, Name Krishna, city Ahmedabad, age 34, gender FEMALE
//		 	], Delhi=[Name Girik, city Delhi, age 50, gender FEMALE
//		 	, Name Darsh, city Delhi, age 49, gender MALE
//		 	, Name Fariq, city Delhi, age 25, gender MALE
//		 	, Name Kabir, city Delhi, age 42, gender MALE
//		 	], Jaipur=[Name Gunbir, city Jaipur, age 56, gender FEMALE
//		 	, Name Rajesh, city Jaipur, age 29, gender MALE
//		 	], Mumbai=[Name Brijesh, city Mumbai, age 39, gender MALE
//		 	, Name Abdul, city Mumbai, age 22, gender MALE
//		 	, Name Jairaj, city Mumbai, age 58, gender FEMALE
//		 	, Name Hitesh, city Mumbai, age 23, gender MALE
//		 	, Name Ekaraj, city Mumbai, age 32, gender FEMALE
//		 	, Name Mitesh, city Mumbai, age 18, gender MALE
//		 	, Name Ranveer, city Mumbai, age 52, gender MALE
//		 	], Bangalore=[Name Jagdish, city Bangalore, age 46, gender MALE
//		 	, Name Naveen, city Bangalore, age 27, gender FEMALE
//		 	, Name Praneel, city Bangalore, age 49, gender MALE
//		 	]}

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getProjectWorkedOnByMostCustomers test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getProjectWorkedOnByMostCustomers(bank));
		// Project [name=Yoda, workers=20]

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getGenderWhoWorkedOnMostProjects test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BankReport.getGenderWhoWorkedOnMostProjects(bank));
		// MALE

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");
    }

    private static void printBusinessReport() {

        System.out.println("---------------- getEmployeesOnSameDisability test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BusinessReport.getEmployeesOnSameDisability(business2));
		// {HEALTHY=[Name Kabir, city Delhi, age 42, gender MALE
		// 	, Name Naveen, city Bangalore, age 27, gender FEMALE
		// 	], ANONIMOUS=[Name Mitesh, city Mumbai, age 18, gender MALE
		// 	, Name Onkar, city Ahmedabad, age 37, gender FEMALE
		// 	, Name Praneel, city Bangalore, age 49, gender MALE
		// 	], DISABLED=[Name Ranveer, city Mumbai, age 52, gender MALE
		// 	, Name Krishna, city Ahmedabad, age 34, gender FEMALE
		// 	]}

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getNumberOfDifferentProjectsWorkedByCurrentFemaleEmployees test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BusinessReport.getNumberOfDifferentProjectsWorkedByCurrentFemaleEmployees(business1));
		// 15

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getEmployeesMaxByReligionMinByGenderSortedByCitySortedByAge test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BusinessReport.getEmployeesMaxByReligionMinByGenderSortedByCitySortedByAge(business1));
		// [Name Fariq, city Delhi, age 25, gender MALE, religion CRISTIANITY
		// , Name Darsh, city Delhi, age 49, gender MALE, religion CRISTIANITY
		// ]


		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getReligionOfEmployeesWithMostAccounts test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BusinessReport.getReligionOfEmployeesWithMostAccounts(business1));
		// CRISTIANITY

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getEmployeesOnSameProjectAndCity test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BusinessReport.getEmployeesOnSameProjectAndCity(business1));
		// {Project [name=Yaeger, workers=8]={Jaipur=[Name Rajesh, city Jaipur, age 29, gender MALE, religion BUDDHISM
		// 	], Bangalore=[Name Jagdish, city Bangalore, age 46, gender MALE, religion CALVINISM
		// 	]}, Project [name=Hornets, workers=10]={Mumbai=[Name Abdul, city Mumbai, age 22, gender MALE, religion BUDDHISM
		// 	, Name Jairaj, city Mumbai, age 58, gender FEMALE, religion DAOISM
		// 	, Name Hitesh, city Mumbai, age 23, gender MALE, religion CALVINISM
		// 	]}, Project [name=Whistler, workers=24]={Mumbai=[Name Brijesh, city Mumbai, age 39, gender MALE, religion BUDDHISM
		// 	]}, Project [name=Coding Region, workers=3]={Delhi=[Name Darsh, city Delhi, age 49, gender MALE, religion CRISTIANITY
		// 	]}, Project [name=Revolution, workers=10]={Delhi=[Name Girik, city Delhi, age 50, gender FEMALE, religion CRISTIANITY
		// 	]}, Project [name=Mercury, workers=60]={Delhi=[Name Girik, city Delhi, age 50, gender FEMALE, religion CRISTIANITY
		// 	]}, Project [name=Fast Ball, workers=14]={Delhi=[Name Fariq, city Delhi, age 25, gender MALE, religion CRISTIANITY
		// 	]}, Project [name=Sputnik, workers=6]={Mumbai=[Name Ekaraj, city Mumbai, age 32, gender FEMALE, religion CRISTIANITY
		// 	]}, Project [name=Stratos, workers=8]={Delhi=[Name Fariq, city Delhi, age 25, gender MALE, religion CRISTIANITY
		// 	], Mumbai=[Name Jairaj, city Mumbai, age 58, gender FEMALE, religion DAOISM
		// 	]}, Project [name=Westerners, workers=12]={Ahmedabad=[Name Arjun, city Ahmedabad, age 20, gender FEMALE, religion BUDDHISM
		// 	]}, Project [name=The Blue Bird, workers=7]={Mumbai=[Name Ekaraj, city Mumbai, age 32, gender FEMALE, religion CRISTIANITY
		// 	]}, Project [name=Strive Training, workers=8]={Mumbai=[Name Hitesh, city Mumbai, age 23, gender MALE, religion CALVINISM
		// 	]}, Project [name=Sirius, workers=6]={Delhi=[Name Darsh, city Delhi, age 49, gender MALE, religion CRISTIANITY
		// 	]}, Project [name=Yoda, workers=20]={Mumbai=[Name Jairaj, city Mumbai, age 58, gender FEMALE, religion DAOISM
		// 	, Name Hitesh, city Mumbai, age 23, gender MALE, religion CALVINISM
		// 	], Bangalore=[Name Jagdish, city Bangalore, age 46, gender MALE, religion CALVINISM
		// 	]}, Project [name=Next Gala, workers=36]={Jaipur=[Name Rajesh, city Jaipur, age 29, gender MALE, religion BUDDHISM
		// 	], Mumbai=[Name Brijesh, city Mumbai, age 39, gender MALE, religion BUDDHISM
		// 	]}, Project [name=Bender Project, workers=6]={Jaipur=[Name Rajesh, city Jaipur, age 29, gender MALE, religion BUDDHISM
		// 	]}, Project [name=Limitless Horizons, workers=8]={Jaipur=[Name Gunbir, city Jaipur, age 56, gender FEMALE, religion CRISTIANITY
		// 	]}, Project [name=Meetup for the God, workers=26]={Ahmedabad=[Name Arjun, city Ahmedabad, age 20, gender FEMALE, religion BUDDHISM
		// 	]}}
			

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");

		System.out.println("---------------- getEmployeesOnSameReligionAndGender test --------------");
		System.out.println();
		System.out.println();

		System.out.println(BusinessReport.getEmployeesOnSameReligionAndGender(business1));
		// {BUDDHISM={FEMALE=[Name Arjun, city Ahmedabad, age 20, gender FEMALE, religion BUDDHISM
		// 	], MALE=[Name Rajesh, city Jaipur, age 29, gender MALE, religion BUDDHISM
		// 	, Name Brijesh, city Mumbai, age 39, gender MALE, religion BUDDHISM
		// 	, Name Abdul, city Mumbai, age 22, gender MALE, religion BUDDHISM
		// 	]}, DAOISM={FEMALE=[Name Jairaj, city Mumbai, age 58, gender FEMALE, religion DAOISM
		// 	]}, CRISTIANITY={FEMALE=[Name Gunbir, city Jaipur, age 56, gender FEMALE, religion CRISTIANITY
		// 	, Name Girik, city Delhi, age 50, gender FEMALE, religion CRISTIANITY
		// 	, Name Ekaraj, city Mumbai, age 32, gender FEMALE, religion CRISTIANITY
		// 	], MALE=[Name Darsh, city Delhi, age 49, gender MALE, religion CRISTIANITY
		// 	, Name Fariq, city Delhi, age 25, gender MALE, religion CRISTIANITY
		// 	]}, CALVINISM={MALE=[Name Jagdish, city Bangalore, age 46, gender MALE, religion CALVINISM
		// 	, Name Hitesh, city Mumbai, age 23, gender MALE, religion CALVINISM
		// 	]}}
			

		System.out.println();
		System.out.println();
		System.out.println("========================================================");
		System.out.println("========================================================");
    }
}
