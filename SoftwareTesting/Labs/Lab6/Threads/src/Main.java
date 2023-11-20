import java.util.concurrent.*;

public class Main {
    public static void main(String[] args) {
        int parkingCapacity = 2;
        ParkingLot parkingLot = new ParkingLot(parkingCapacity);

        ExecutorService executorService = Executors.newCachedThreadPool();

        // Создаем несколько потоков для разных машин
        executorService.execute(new Car("A", parkingLot));
        executorService.execute(new Car("B", parkingLot));
        executorService.execute(new Car("C", parkingLot));
        executorService.execute(new Car("D", parkingLot));
        executorService.execute(new Car("E", parkingLot));
        executorService.execute(new Car("F", parkingLot));
        executorService.shutdown();
    }
}
