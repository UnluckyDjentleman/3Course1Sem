package flowers;
public class Rose extends Flower {
    private String fragrance;  // Уникальный параметр для розы

    public Rose(double price, int freshnessLevel, int stemLength, String fragrance) {
        super("Rose", price, freshnessLevel, stemLength);
        this.fragrance = fragrance;
    }

    @Override
    public String getColor() {
        return "Red";  // Розы чаще всего красные
    }

    public String getFragrance() {
        return fragrance;
    }

    public void setFragrance(String fragrance) {
        this.fragrance = fragrance;
    }
}