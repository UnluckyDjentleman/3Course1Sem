import java.util.*;

public class Main {
    public static void main(String[] args) {
        try {
            // Оценка ниже 0 или выше 10
            Map<String, Integer> subjects1 = new HashMap<>();
            subjects1.put("Математика", 11); // Ошибка: оценка выше 10
            Student student1 = new Student("Иван", subjects1);
        } catch (UniversityException e) {
            System.out.println(e.getMessage());
        }

        try {
            // Отсутствие предметов у студента (должен быть хотя бы один)
            Map<String, Integer> subjects2 = new HashMap<>();
            Student student2 = new Student("Анна", subjects2); // Ошибка: отсутствие предметов у студента
        } catch (UniversityException e) {
            System.out.println(e.getMessage());
        }

        try {
            // Отсутствие студентов в группе
            Map<String, Integer> subjects3 = new HashMap<>();
            subjects3.put("Математика", 8);
            Student student3 = new Student("Сергей", subjects3);

            List<Student> students = new ArrayList<>();
            Group group = new Group("101", students); // Ошибка: отсутствие студентов в группе
        } catch (UniversityException e) {
            System.out.println(e.getMessage());
        }

        try {
            // Отсутствие групп на факультете
            Map<String, Integer> subjects4 = new HashMap<>();
            subjects4.put("Математика", 9);
            Student student4 = new Student("Мария", subjects4);

            List<Student> students = new ArrayList<>();
            students.add(student4);
            Group group = new Group("102", students);

            List<Group> groups = new ArrayList<>();
            Faculty faculty = new Faculty("Физико-математический", groups); // Ошибка: отсутствие групп на факультете
        } catch (UniversityException e) {
            System.out.println(e.getMessage());
        }

        try {
            // Отсутствие факультетов в университете
            Map<String, Integer> subjects5 = new HashMap<>();
            subjects5.put("Математика", 7);
            Student student5 = new Student("Алексей", subjects5);

            List<Student> students = new ArrayList<>();
            students.add(student5);
            Group group = new Group("103", students);

            List<Group> groups = new ArrayList<>();
            groups.add(group);
            Faculty faculty = new Faculty("Физико-математический", groups);

            List<Faculty> faculties = new ArrayList<>();
            University university = new University("БГУ", faculties); // Ошибка: отсутствие факультетов в университете
        } catch (UniversityException e) {
            System.out.println(e.getMessage());
        }

        try {
            // Создаем студентов
            Map<String, Integer> subjects1 = new HashMap<>();
            subjects1.put("Математика", 9);
            subjects1.put("Физика", 8);
            Student student1 = new Student("Иван", subjects1);

            Map<String, Integer> subjects2 = new HashMap<>();
            subjects2.put("Математика", 7);
            subjects2.put("Физика", 6);
            Student student2 = new Student("Анна", subjects2);

            // Создаем группы
            List<Student> studentsGroup1 = new ArrayList<>();
            studentsGroup1.add(student1); //Иван
            studentsGroup1.add(student2); //Анна
            Group group1 = new Group("101", studentsGroup1); //Иван + Анна

            List<Student> studentsGroup2 = new ArrayList<>();
            studentsGroup2.add(student2);
            Group group2 = new Group("102", studentsGroup2); //Анна

            // Создаем факультеты
            List<Group> groupsFaculty1 = new ArrayList<>();
            groupsFaculty1.add(group1);
            groupsFaculty1.add(group2);
            Faculty faculty1 = new Faculty("Физико-математический", groupsFaculty1); //Иван + Анна

            List<Group> groupsFaculty2 = new ArrayList<>();
            groupsFaculty2.add(group1);
            Faculty faculty2 = new Faculty("Гуманитарный", groupsFaculty2); //Анна

            // Создаем университет
            List<Faculty> faculties = new ArrayList<>();
            faculties.add(faculty1);
            faculties.add(faculty2);
            University university = new University("БГУ", faculties);

            // Выполняем операции
            System.out.println("Средний балл по всем предметам студента " + student1.getName() + ": " + student1.getAverageScore());
            System.out.println("Средний балл по предмету 'Математика' в группе " + group1.getName() + ": " + group1.getAverageScore("Математика"));
            System.out.println("Средний балл по предмету 'Физика' на факультете " + faculty1.getName() + ": " + faculty1.getAverageScore("Физика"));
            System.out.println("Средний балл по предмету 'Математика' в университете " + university.getName() + ": " + university.getAverageScore("Математика"));
        } catch (UniversityException e) {
            System.out.println(e.getMessage());
        }
    }
}
