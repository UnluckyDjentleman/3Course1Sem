import java.util.List;


class InvalidGradeException extends Exception {
    public InvalidGradeException(String message) {
        super(message);
    }
}

class NoGradesException extends RuntimeException {
    public NoGradesException(String message) {
        super(message);
    }
}

class NoStudentsException extends RuntimeException {
    public NoStudentsException(String message) {
        super(message);
    }
}

class NoGroupsException extends RuntimeException {
    public NoGroupsException(String message) {
        super(message);
    }
}

class NoFacultiesException extends RuntimeException {
    public NoFacultiesException(String message) {
        super(message);
    }
}

public class Main {
    public static void main(String[] args) {
        University university = new University();
        Faculty engineeringFaculty = new Faculty("Engineering");
        Faculty scienceFaculty = new Faculty("Science");

        university.addFaculty(engineeringFaculty);
        university.addFaculty(scienceFaculty);

        Group groupA = new Group("Group A");
        Group groupB = new Group("Group B");

        engineeringFaculty.addGroup(groupA);
        scienceFaculty.addGroup(groupB);

        Student student1 = new Student("John");
        Student student2 = new Student("Alice");
        Student student3 = new Student("Bob");

        groupA.addStudent(student1);
        groupA.addStudent(student2);
        groupB.addStudent(student3);

        try {
            student1.addGrade("Math", 8);
            student1.addGrade("Physics", 9);
            student1.addGrade("Chemistry", 7);

            student2.addGrade("Math", 7);
            student2.addGrade("Physics", 8);
            student2.addGrade("Chemistry", 6);

            student3.addGrade("Biology", 9);
        } catch (InvalidGradeException e) {
            System.out.println("Invalid grade: " + e.getMessage());
        }

        try {
            double avgGradeStudent1 = student1.calculateAverageGrade();
            System.out.println("Средний балл для студента 1: " + avgGradeStudent1);

            double avgGradeInMathForGroupA = calculateAverageGradeInSubject(groupA, "Math");
            System.out.println("Средний балл по математике для Группы A: " + avgGradeInMathForGroupA);

            double avgGradeInMathForEngineeringFaculty = calculateAverageGradeInSubject(engineeringFaculty, "Math");
            System.out.println("Средний балл по математике для Факультета Инженерии: " + avgGradeInMathForEngineeringFaculty);

            double avgGradeInMathForUniversity = calculateAverageGradeInSubject(university, "Math");
            System.out.println("Средний балл по математике для Университета: " + avgGradeInMathForUniversity);

        } catch (NoGradesException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static double calculateAverageGradeInSubject(Group group, String subject) {
        List<Student> students = group.getStudents();
        if (students.isEmpty()) {
            throw new NoStudentsException("В группе нет учеников.");
        }

        double sum = 0.0;
        int count = 0;
        for (Student student : students) {
            List<SubjectGrade> grades = student.getGrades();
            for (SubjectGrade grade : grades) {
                if (grade.getSubject().equals(subject)) {
                    sum += grade.getGrade();
                    count++;
                }
            }
        }

        if (count == 0) {
            throw new NoGradesException("В группе нет оценок по указанному предмету.");
        }

        return sum / count;
    }

    public static double calculateAverageGradeInSubject(Faculty faculty, String subject) {
        List<Group> groups = faculty.getGroups();
        if (groups.isEmpty()) {
            throw new NoGroupsException("На факультете нет групп.");
        }

        double sum = 0.0;
        int count = 0;
        for (Group group : groups) {
            try {
                double avgGrade = calculateAverageGradeInSubject(group, subject);
                sum += avgGrade;
                count++;
            } catch (NoGradesException e) {
            }
        }

        if (count == 0) {
            throw new NoGradesException("На факультете нет оценок по указанному предмету.");
        }

        return sum / count;
    }

    public static double calculateAverageGradeInSubject(University university, String subject) {
        List<Faculty> faculties = university.getFaculties();
        if (faculties.isEmpty()) {
            throw new NoFacultiesException("В университете нет факультетов.");
        }

        double sum = 0.0;
        int count = 0;
        for (Faculty faculty : faculties) {
            try {
                double avgGrade = calculateAverageGradeInSubject(faculty, subject);
                sum += avgGrade;
                count++;
            } catch (NoGradesException e) {
            }
        }

        if (count == 0) {
            throw new NoGradesException("Нет оценок по указанному предмету в вузе.");
        }

        return sum / count;
    }
}
