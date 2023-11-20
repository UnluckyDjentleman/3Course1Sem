// Файл: Peony.java
package flowers;

public class Peony extends Flower {
    private String petalShape;  // Уникальный параметр для пиона (форма лепестка)

    public Peony(double price, int freshnessLevel, int stemLength, String petalShape) {
        super("Peony", price, freshnessLevel, stemLength);
        this.petalShape = petalShape;
    }

    @Override
    public String getColor() {
        return "Pink";  // Пионы чаще всего розовые
    }

    public String getPetalShape() {
        return petalShape;
    }

    public void setPetalShape(String petalShape) {
        this.petalShape = petalShape;
    }
}