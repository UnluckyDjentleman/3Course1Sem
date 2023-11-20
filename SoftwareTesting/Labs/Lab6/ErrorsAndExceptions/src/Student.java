import java.util.*;

public class Student {
    String name;
    Map<String, Integer> subjects;

    public Student(String name, Map<String, Integer> subjects) throws UniversityException {
        if (subjects.isEmpty()) {
            throw new UniversityException("Студент должен иметь хотя бы один предмет");
        }
        for (int score : subjects.values()) {
            if (score < 0 || score > 10) {
                throw new UniversityException("Оценка должна быть в диапазоне от 0 до 10");
            }
        }
        this.name = name;
        this.subjects = subjects;
    }

    public double getAverageScore() {
        int total = 0;
        for (int score : subjects.values()) {
            total += score;
        }
        return (double) total / subjects.size();
    }

    public String getName() {
        return name;
    }
}
