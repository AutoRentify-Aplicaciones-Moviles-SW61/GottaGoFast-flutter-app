import 'package:app_tentify_frfr/renting/widgets/car_card.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:flutter/material.dart';
class FilteredCarPage extends StatelessWidget {
  final String selectedBrand;
  final double selectedBudget;
  const FilteredCarPage({
    Key? key,
    required this.selectedBrand,
    required this.selectedBudget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Lista de autos codificada
    List<Car> hardcodedCars = [
      // Tu lista de carros aquí
    ];
    // Filtrar los autos según los criterios seleccionados
    List<Car> filteredCars = hardcodedCars.where((car) {
      return (selectedBrand.isEmpty || car.brand == selectedBrand) &&
          (selectedBudget == 0 || car.carPrice <= selectedBudget);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtered Cars"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            for (Car car in filteredCars) CarCard(car: car),
            if (filteredCars.isEmpty)
              Center(
                child: Text(
                  'No cars match your filters.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}