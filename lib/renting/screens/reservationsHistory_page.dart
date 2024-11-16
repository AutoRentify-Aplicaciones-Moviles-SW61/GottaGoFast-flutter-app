import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/reservationdetails_page.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/carsService.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';

class ReservationHistoryPage extends StatelessWidget {
  final CarService carService;
  final CommentService commentService;

  const ReservationHistoryPage({super.key, required this.carService, required this.commentService});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final currentUser = authService.getCurrentUser();
    final reservations = currentUser?.reservations?.where((reservation) => reservation.status == 'ACTIVE').toList() ?? [];
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
      isAvailable: false,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationDetailPage(
                        reservation: reservation,
                        car: car,
                        carService: carService,
                        commentService: commentService,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}