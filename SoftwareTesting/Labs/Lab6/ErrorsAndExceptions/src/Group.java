import java.util.*;

public class Group {
    String name;
    List<Student> students;

    public Group(String name, List<Student> students) throws UniversityException {
        if (students.isEmpty()) {
            throw new UniversityException("В группе должен быть хотя бы один студент");
        }
        this.name = name;
        this.students = students;
    }

    public double getAverageScore(String subject) {
        int total = 0;
        int count = 0;
        for (Student student : students) {
            if (student.subjects.containsKey(subject)) {
                total += student.subjects.get(subject);
                count++;
            }
        }
        return count > 0 ? (double) total / count : 0;
    }

    public String getName() {
        return name;
    }
}
