package task2;

public class Test2 {
    public static void main(String[] args){
        Course curs = new Course();
        curs.title = "Programare Orientata pe obiecte";
        curs.description = "Introducere in Java";
        curs.students = new Student[4];

        Student s1 = new Student();
        s1.setName("Mihai");
        s1.setYear(2);

        Student s2 = new Student();
        s2.setName("Raul");
        s2.setYear(2);

        Student s3 = new Student();
        s3.setName("Iulian");
        s3.setYear(3);

        Student s4 = new Student();
        s4.setName("Andrei");
        s4.setYear(4);

        curs.students[0] = s1;
        curs.students[1] = s2;
        curs.students[2] = s3;
        curs.students[3] = s4;

        Student[] students_sorted = curs.filterYear(Integer.parseInt(args[0]));

        int i;
        for(i = 0; i < students_sorted.length; i++)
            System.out.println(students_sorted[i].getName());
    }
}
