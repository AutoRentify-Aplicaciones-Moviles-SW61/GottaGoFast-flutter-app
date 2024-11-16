import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/renting/screens/newcomment_page.dart';
import 'package:app_tentify_frfr/shared/services/carsService.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';

class ReservationDetailPage extends StatelessWidget {
  final Reservation reservation;
  final Car car;
  final CarService carService;
  final CommentService commentService;

  const ReservationDetailPage({
    Key? key,
    required this.reservation,
    required this.car,
    required this.carService,
    required this.commentService,
  }) : super(key: key);

  void _navigateToNewCommentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewcommentPage(carId: car.id, commentService: commentService),
      ),
    );
  }

  void _finalizeReservation(BuildContext context) {
    reservation.status = 'FINISHED';
    car.isAvailable = true;
    carService.updateCarAvailability(car.id, true); // Update car status in the service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reservation finalized')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(car.imageData, width: double.infinity, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text('Car Name: ${car.carName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Brand: ${car.brand}', style: const TextStyle(fontSize: 16)),
            Text('Model: ${car.carModel}', style: const TextStyle(fontSize: 16)),
            Text('Description: ${car.carDescription}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Reservation ID: ${reservation.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Pickup Location: ${reservation.pickupLocation}', style: const TextStyle(fontSize: 16)),
            Text('Dropoff Location: ${reservation.dropoffLocation}', style: const TextStyle(fontSize: 16)),
            Text('Pickup Date: ${reservation.pickupDate}', style: const TextStyle(fontSize: 16)),
            Text('Dropoff Date: ${reservation.dropoffDate}', style: const TextStyle(fontSize: 16)),
            Text('Total Price: \$${reservation.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToNewCommentPage(context),
              child: const Text('New Comment'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _finalizeReservation(context),
              child: const Text('Finalize Reservation'),
            ),
          ],
        ),
      ),
    );
  }
}