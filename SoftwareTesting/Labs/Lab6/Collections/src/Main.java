import bouquet.FlowerBouquet;
import flowers.Rose;
import flowers.Tulip;
import flowers.Peony;
import accessories.Accessory;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        // Создание цветов
        Rose rose = new Rose(5.0, 3, 7, "Fragrant");
        Tulip tulip = new Tulip(3.0, 2, 4, true);
        Peony peony = new Peony(4.0, 5,5, "Ruffled");

        Accessory ribbon = new Accessory("Ribbon", 2.0);
        Accessory paper = new Accessory("Paper", 1.0);

        // Создание букета
        FlowerBouquet bouquet = new FlowerBouquet(List.of(rose, tulip, peony), List.of(ribbon, paper));

        // Вывод стоимости букета
        System.out.println("Bouquet price: " + bouquet.calculatePrice());
        System.out.println("\n");

        // Сортировка цветов по уровню свежести
        bouquet.sortFlowersByFreshness();
        // Вывод отсортированных цветов
        System.out.println("Sorted flowers by freshness:");
        for (flowers.Flower flower : bouquet.getFlowers()) {
            System.out.println("Flower: " + flower.getName() + ", Freshness Level: " + flower.getFreshnessLevel());
        }
        System.out.println("\n");

        // Поиск цветов в букете с длиной стебля от 2 до 5
        List<flowers.Flower> filteredFlowers = bouquet.findFlowersByStemLength(2, 5);

        // Вывод найденных цветов
        System.out.println("Flowers with stem length between 2 and 5:");
        for (flowers.Flower flower : filteredFlowers) {
            System.out.println("Flower: " + flower.getName() + ", Stem Length: " + flower.getStemLength());
        }
    }
}
