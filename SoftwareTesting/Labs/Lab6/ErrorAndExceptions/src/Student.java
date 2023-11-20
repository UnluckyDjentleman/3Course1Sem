import java.util.ArrayList;
import java.util.List;

public class Student {
    private String name;
    private List<SubjectGrade> grades;

    public Student(String name) {
        this.name = name;
        grades = new ArrayList<>();
    }

    public void addGrade(String subject, int grade) throws InvalidGradeException {
        if (grade < 0 || grade > 10) {
            throw new InvalidGradeException("Invalid grade: " + grade);
        }
        grades.add(new SubjectGrade(subject, grade));
    }

    public double calculateAverageGrade() {
        if (grades.isEmpty()) {
            throw new NoGradesException("У ученика нет оценок.");
        }

        double sum = 0.0;
        for (SubjectGrade grade : grades) {
            sum += grade.getGrade();
        }

        return sum / grades.size();
    }

    public List<SubjectGrade> getGrades() {
        return grades;
    }
}
