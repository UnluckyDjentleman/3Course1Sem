// Файл: Tulip.java
package flowers;

public class Tulip extends Flower {
    private boolean isSpringFlower;  // Уникальный параметр для тюльпана

    public Tulip(double price, int freshnessLevel, int stemLength, boolean isSpringFlower) {
        super("Tulip", price, stemLength, freshnessLevel);
        this.isSpringFlower = isSpringFlower;
    }

    @Override
    public String getColor() {
        return "Various";  // Тюльпаны могут быть разных цветов
    }

    public boolean isSpringFlower() {
        return isSpringFlower;
    }

    public void setSpringFlower(boolean springFlower) {
        isSpringFlower = springFlower;
    }
}
