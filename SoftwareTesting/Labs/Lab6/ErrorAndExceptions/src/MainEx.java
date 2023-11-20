public class MainEx {
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
            // Добавление оценок вне допустимого диапазона (ниже 0 и выше 10)
            student1.addGrade("Math", 11);
        } catch (InvalidGradeException e) {
            System.out.println("Invalid grade: " + e.getMessage());
        }

        try {
            // Вычисление среднего балла для студента без оценок
            double avgGradeStudent2 = student2.calculateAverageGrade();
        } catch (NoGradesException e) {
            System.out.println("Error: " + e.getMessage());
        }

        try {
            // Попытка вычисления среднего балла для группы без студентов
            double avgGradeInMathForGroupB = Main.calculateAverageGradeInSubject(groupB, "Math");
        } catch (NoStudentsException e) {
            System.out.println("Error: " + e.getMessage());
        }

        try {
            // Попытка вычисления среднего балла для факультета без групп
            double avgGradeInMathForScienceFaculty = Main.calculateAverageGradeInSubject(scienceFaculty, "Math");
        } catch (NoGroupsException e) {
            System.out.println("Error: " + e.getMessage());
        }

        try {
            // Попытка вычисления среднего балла для университета без факультетов
            double avgGradeInMathForUniversity = Main.calculateAverageGradeInSubject(university, "Math");
        } catch (NoFacultiesException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
