import java.util.Objects;

public class Student implements Comparable<Student>{
    private final String name;
    private final String surname;
    private final long id;
    private final double averageGrade;

    @Override
    public int compareTo(Student o) {
        if(averageGrade == o.averageGrade && name.equals(o.name))
            return surname.compareTo(o.surname);


        if(averageGrade == o.averageGrade)
            return name.compareTo(o.name);

        if (averageGrade - o.averageGrade > 0){
            return 1;
        }

        return -1;
    }

    Student(String name, String surname, long id, double averageGrade){
        this.name = name;
        this.surname =surname;
        this.id = id;
        this.averageGrade = averageGrade;
    }

    @Override
    public String toString() {
        return id + ") " + name + " " + surname + ", " + averageGrade + " ";
    }

    public long getId() {
        return id;
    }

    public double getAverageGrade() {
        return averageGrade;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Student)) {
            return false;
        }
        Student student = (Student) o;
        return getId() == student.getId() &&
                Double.compare(student.getAverageGrade(), getAverageGrade()) == 0 &&
                Objects.equals(name, student.name) &&
                Objects.equals(surname, student.surname);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, surname, getId(), getAverageGrade());
    }
}
