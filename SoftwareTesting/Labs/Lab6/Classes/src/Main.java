import java.util.Date;

public class Main {
    public static void main(String[] args) {
        // Создать массив объектов
        Student[] students = new Student[3];
        students[0] = new Student(1, "Иванов", "Петр", "Сергеевич", new Date(2000, 5, 15), "Москва", "123-456-789", "Факультет1", 1, "Группа1");
        students[1] = new Student(2, "Петров", "Иван", "Александрович", new Date(2001, 3, 20), "Санкт-Петербург", "987-654-321", "Факультет2", 2, "Группа2");
        students[2] = new Student(3, "Сидоров", "Андрей", "Викторович", new Date(1999, 7, 10), "Новосибирск", "111-222-333", "Факультет1", 3, "Группа1");

        // a) Список студентов заданного факультета
        String facultyToSearch = "Факультет1";
        System.out.println("Студенты факультета " + facultyToSearch + ":");
        for (Student student : students) {
            if (student.getFaculty().equals(facultyToSearch)) {
                System.out.println(student);
            }
        }
        System.out.println('\n');

        // b) Списки студентов для каждого факультета и курса
        System.out.println("Списки студентов по факультетам и курсам:");
        for (Student student : students) {
            System.out.println("Факультет: " + student.getFaculty() + ", Курс: " + student.getCourse());
        }
        System.out.println('\n');

        // c) Список студентов, родившихся после заданного года
        int birthYearToSearch = 2000;
        System.out.println("Студенты, родившиеся после " + birthYearToSearch + " года:");
        for (Student student : students) {
            if (student.getBirthDate().getYear() > birthYearToSearch) {
                System.out.println(student);
            }
        }
        System.out.println('\n');

        // d) Список учебной группы
        String groupToSearch = "Группа1";
        System.out.println("Студенты группы " + groupToSearch + ":");
        for (Student student : students) {
            if (student.getGroup().equals(groupToSearch)) {
                System.out.println(student);
            }
        }
    }
}
