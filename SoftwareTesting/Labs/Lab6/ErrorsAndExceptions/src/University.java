import java.util.*;

public class University {
    String name;
    List<Faculty> faculties;

    public University(String name, List<Faculty> faculties) throws UniversityException {
        if (faculties.isEmpty()) {
            throw new UniversityException("В университете должен быть хотя бы один факультет");
        }
        this.name = name;
        this.faculties = faculties;
    }

    public double getAverageScore(String subject) {
        int total = 0;
        int count = 0;
        for (Faculty faculty : faculties) {
            for (Group group : faculty.groups) {
                for (Student student : group.students) {
                    if (student.subjects.containsKey(subject)) {
                        total += student.subjects.get(subject);
                        count++;
                    }
                }
            }
        }
        return count > 0 ? (double) total / count : 0;
    }

    public String getName() {
        return name;
    }
}
