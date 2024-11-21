import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import '../widgets/car_card.dart';
class CarListPage extends StatelessWidget {
  final String brand;
  final List<Car> cars;
  const CarListPage({Key? key, required this.brand, required this.cars}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Car> filteredCars = cars.where((car) => car.brand == brand).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars of $brand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            for (Car car in filteredCars) CarCard(car: car),
          ],
        ),
      ),
    );
  }
}