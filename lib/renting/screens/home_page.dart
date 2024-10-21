import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/screens/search_page.dart';
import 'package:lead_your_way/shared/models/car.dart';
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
      selectedBrand = brand;
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
      // Your hardcoded cars here
    ];

    List<Car> filteredCars = hardcodedCars.where((car) {
      return (selectedBrand.isEmpty || car.brand == selectedBrand) &&
          (selectedBudget == 0 || car.carPrice <= selectedBudget);
    }).toList();

    return Scaffold(
      appBar: _showBackButton
          ? AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _onBackButtonPressed,
        ),
      )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Drive in style",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              "You want it you got it",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              "Popular Brands",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              "Select one between our most popular brands available",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ChoiceChip(
                    avatar: Image.network('https://sommelier.com.pe/wp-content/uploads/Toyota-logo.png'),
                    label: const Text("Toyota"),
                    selected: selectedBrand == "Toyota",
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("Toyota");
                    },
                  ),
                  ChoiceChip(
                    avatar: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/768px-BMW.svg.png'),
                    label: const Text("BMW"),
                    selected: selectedBrand == "BMW",
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("BMW");
                    },
                  ),
                  ChoiceChip(
                    avatar: Image.network('https://1000marcas.net/wp-content/uploads/2020/01/Jeep-Logo-1970-1.png'),
                    label: const Text("Jeep"),
                    selected: selectedBrand == "Jeep",
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("Jeep");
                    },
                  ),
                  ChoiceChip(
                    avatar: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Ford_logo_flat.svg/2560px-Ford_logo_flat.svg.png'),
                    label: const Text("Ford"),
                    selected: selectedBrand == "Ford",
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("Ford");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Budget",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              "Select a maximum of price to filter",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ChoiceChip(
                    label: const Text("50"),
                    selected: selectedBudget == 50,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBudgetSelected(50);
                    },
                  ),
                  ChoiceChip(
                    label: const Text("100"),
                    selected: selectedBudget == 100,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBudgetSelected(100);
                    },
                  ),
                  ChoiceChip(
                    label: const Text("200"),
                    selected: selectedBudget == 200,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBudgetSelected(200);
                    },
                  ),
                  ChoiceChip(
                    label: const Text("300"),
                    selected: selectedBudget == 300,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBudgetSelected(300);
                    },
                  ),
                  ChoiceChip(
                    label: const Text("400"),
                    selected: selectedBudget == 400,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBudgetSelected(400);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  for (Car car in filteredCars)
                    CarCard(car: car),
                  const SizedBox(height: 20),
                  Image.network('https://vehicle-images.dealerinspire.com/stock-images/thumbnails/large/chrome/6f177bf506399bda7f9826048fd58b5e.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}