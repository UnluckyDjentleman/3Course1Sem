package bouquet;

import flowers.Flower;
import accessories.Accessory;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class FlowerBouquet {
    private List<Flower> flowers;
    private List<Accessory> accessories;

    public FlowerBouquet(List<Flower> flowers, List<Accessory> accessories) {
        this.flowers = new ArrayList<>(flowers);
        this.accessories = new ArrayList<>(accessories);
    }

    public List<Flower> getFlowers() {
        return flowers;
    }
    public double calculatePrice() {
        double flowerCost = flowers.stream().mapToDouble(Flower::getPrice).sum();
        double accessoryCost = accessories.stream().mapToDouble(Accessory::getPrice).sum();
        return flowerCost + accessoryCost;
    }

    public void sortFlowersByFreshness() {
        flowers.sort(Comparator.comparingInt(Flower::getFreshnessLevel));
    }

    public List<Flower> findFlowersByStemLength(int minLength, int maxLength) {
        List<Flower> result = new ArrayList<>();
        for (Flower flower : flowers) {
            int stemLength = flower.getStemLength();
            if (stemLength >= minLength && stemLength <= maxLength) {
                result.add(flower);
            }
        }
        return result;
    }
}
