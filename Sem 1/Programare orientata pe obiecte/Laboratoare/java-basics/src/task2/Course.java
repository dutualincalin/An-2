package task2;

public class Course {
    String title;
    String description;
    Student[] students;

    public Student[] filterYear(int year) {
        int i, j = 0,k = 0;

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

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}