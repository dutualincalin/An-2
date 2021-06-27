package task4;

public class Course {
    private String title;
    private String description;
    private Student[] students;

    public Student[] filterYear(int year) {
        int i;
        int j = 0;
        int k = 0;

        for (i = 0; i <= students.length - 1; i++)
           if (students[i].getYear() == year){
               k++;
           }

        Student[] stud_year = new Student[k];

        for (i = 0; i <= students.length - 1; i++)

            if (students[i].getYear() == year) {
                stud_year[j] = students[i];
                j++;
            }

        return stud_year;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Student[] getStudents() {
        return students;
    }

    public void setStudents(Student[] students) {
        this.students = students;
    }
}