import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/search_page.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import '../widgets/car_card.dart';

class HomePage extends StatefulWidget {
  final void Function(String) onBrandSelected;
  final void Function(double) onBudgetSelected;

  const HomePage({Key? key, required this.onBrandSelected, required this.onBudgetSelected}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showBackButton = false;
  String selectedBrand = '';
  double selectedBudget = 0;

  void _onBrandSelected(String brand) {
    widget.onBrandSelected(brand);
    setState(() {
      selectedBrand = brand == "All" ? '' : brand;
      _showBackButton = true;
    });
  }

  void _onBudgetSelected(double budget) {
    widget.onBudgetSelected(budget);
    setState(() {
      selectedBudget = budget;
      _showBackButton = true;
    });
  }

  void _onBackButtonPressed() {
    widget.onBrandSelected('');
    widget.onBudgetSelected(0);
    setState(() {
      _showBackButton = false;
      selectedBrand = '';
      selectedBudget = 0;
    });
    Navigator.of(context).pop(); // Asegúrate de que esto navegue correctamente
  }

  @override
  Widget build(BuildContext context) {
    List<Car> hardcodedCars = [
    ];

    List<Car> filteredCars = hardcodedCars.where((car) {
      bool matchesBrand = selectedBrand.isEmpty || selectedBrand == 'All' || car.brand == selectedBrand;
      bool matchesBudget = selectedBudget == 0 || car.carPrice <= selectedBudget;
      return matchesBrand && matchesBudget;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AUTO RENTIFY'),
        backgroundColor: Colors.blueAccent,
        leading: Container(),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Dropdown para marca
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Selecciona la marca"),
            DropdownButton<String>(
              value: selectedBrand.isEmpty ? null : selectedBrand,
              //cuando selecciono All muestra todos
              hint: Text('Marca'),
              items: ['All','Toyota', 'BMW', 'Jeep', 'Ford', 'Porsche', 'Tesla', 'Mazda', 'Audi', 'Chevrolet', 'Lincoln']
                  .map((brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _onBrandSelected(value);
                }
              },
            ),
          ],

            ),
        // Dropdown para presupuesto
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Selecciona el presupuesto máximo"),
            DropdownButton<double>(
              value: selectedBudget == 0 ? null : selectedBudget,
              hint: Text('Presupuesto'),
              items: [0,50, 100, 200, 300, 400, 500]
                  .map((budget) {
                return DropdownMenuItem<double>(
                  value: budget.toDouble(),
                  child: Text("\$${budget.toString()}"),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _onBudgetSelected(value);
                }
              },
            ),
          ],

            ),
            // Espacio entre los filtros y los resultados
            SizedBox(height: 16),
            // Lista de coches filtrados
            Expanded(
              child: ListView.builder(
                itemCount: filteredCars.length,
                itemBuilder: (context, index) {
                  return CarCard(car: filteredCars[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}