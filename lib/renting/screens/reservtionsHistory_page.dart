import 'package:flutter/material.dart';
import 'package:lead_your_way/shared/models/reservation.dart';
import 'package:lead_your_way/shared/services/authService.dart';
import 'package:lead_your_way/shared/services/carsService.dart';
import 'package:lead_your_way/shared/models/car.dart';

class ReservationHistoryPage extends StatelessWidget {
  const ReservationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = MockAuthService();
    final carService = CarService();
    final currentUser = authService.getCurrentUser();
    final reservations = currentUser?.reservations ?? [];
    final cars = carService.getAllCars();

    final defaultCar = Car(
      id: 0,
      passengers: 0,
      luggageCapacity: 0,
      carName: 'Unknown',
      brand: 'Unknown',
      carPrice: 0.0,
      carDescription: 'Unknown',
      carModel: 'Unknown',
      imageData: 'https://via.placeholder.com/50',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reservations'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];
            final car = cars.firstWhere(
                  (car) => car.id == reservation.vehicleId,
              orElse: () => defaultCar,
            );

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.network(car.imageData, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(
                    'Reservation ID: ${reservation.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pickup: ${reservation.pickupLocation}'),
                      Text('Dropoff: ${reservation.dropoffLocation}'),
                      Text('Pickup Date: ${reservation.pickupDate}'),
                      Text('Dropoff Date: ${reservation.dropoffDate}'),
                      Text('Total Price: \$${reservation.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}