package task4;

public class Test4 {

    public static void main(String[] args) {
        Course curs = new Course();
        curs.setTitle("POO");
        curs.setDescription("Introducere in Java");

        Student[] students = new Student[4];

        students[0] = new Student();
        students[0].setName("Mihai");
        students[0].setYear(2);

        students[1] = new Student();
        students[1].setName("Raul");
        students[1].setYear(2);

        students[2] = new Student();
        students[2].setName("Iulian");
        students[2].setYear(3);

        students[3] = new Student();
        students[3].setName("Andrei");
        students[3].setYear(4);

        curs.setStudents(students);

        Student[] students_sorted = curs.filterYear(Integer.parseInt(args[0]));

        int i;
        for (i = 0; i < students_sorted.length; i++)
            System.out.println(students_sorted[i].getName());
    }
}
