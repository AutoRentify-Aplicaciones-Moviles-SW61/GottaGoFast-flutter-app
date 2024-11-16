import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/rent_page.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';

class BicycleCard extends StatelessWidget {
  final Car car;
  final AuthService authservice;
  final CommentService commentService;

  BicycleCard({required this.car, required this.authservice, required this.commentService});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            car.imageData, // Assuming you have image URLs in your model.
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.carName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  car.carDescription,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: \$${car.carPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text('Size: ${car.passengers}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Model: ${car.carModel}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Brand: ${car.brand}',
                            style: const TextStyle(fontSize: 16))
                      ],
                    ),
                    const Spacer(), // Pushes "Rent" button to the right
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RentPage(car: car, authService: authservice, commentService: commentService)));
                      },
                      child: const Text("Rent"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}