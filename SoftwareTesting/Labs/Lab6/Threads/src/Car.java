public class Car implements Runnable {
    private final String name;
    private final ParkingLot parkingLot;

    public Car(String name, ParkingLot parkingLot) {
        this.name = name;
        this.parkingLot = parkingLot;
    }

    @Override
    public void run() {
        try {
            parkingLot.parkCar(name);
            Thread.sleep(4000); // Машина находится на стоянке
            parkingLot.leaveParking(name);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
