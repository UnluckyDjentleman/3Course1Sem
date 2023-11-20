public class SubjectGrade {
    private String subject;
    private int grade;

    public SubjectGrade(String subject, int grade) {
        this.subject = subject;
        this.grade = grade;
    }

    public int getGrade() {
        return grade;
    }

    public String getSubject() {
        return subject;
    }
}
