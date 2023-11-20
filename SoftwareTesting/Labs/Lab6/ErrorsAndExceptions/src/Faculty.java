import java.util.*;

public class Faculty {
    String name;
    List<Group> groups;

    public Faculty(String name, List<Group> groups) throws UniversityException {
        if (groups.isEmpty()) {
            throw new UniversityException("На факультете должна быть хотя бы одна группа");
        }
        this.name = name;
        this.groups = groups;
    }

    public double getAverageScore(String subject) {
        int total = 0;
        int count = 0;
        for (Group group : groups) {
            for (Student student : group.students) {
                if (student.subjects.containsKey(subject)) {
                    total += student.subjects.get(subject);
                    count++;
                }
            }
        }
        return count > 0 ? (double) total / count : 0;
    }

    public String getName() {
        return name;
    }
}
