import java.util.concurrent.Semaphore;

public class ParkingLot {
    private final int capacity;
    private final Semaphore semaphore;

    public ParkingLot(int capacity) {
        this.capacity = capacity;
        this.semaphore = new Semaphore(capacity, true);
    }

    public void parkCar(String carName) throws InterruptedException {
        semaphore.acquire();
        System.out.println("Машина " + carName + " припарковалась");
    }

    public void leaveParking(String carName) {
        semaphore.release();
        System.out.println("Машина " + carName + " уехала со стоянки");
    }
}
