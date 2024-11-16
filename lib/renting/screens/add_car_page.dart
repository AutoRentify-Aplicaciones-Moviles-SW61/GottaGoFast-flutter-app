import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/auth/screens/login.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/carsService.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/widgets/gottagofast_navigator.dart';

class AddCarPage extends StatefulWidget {
  final AuthService authService;
  final CarService carService;

  const AddCarPage({Key? key, required this.authService, required this.carService}) : super(key: key);

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController imageDataController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();
  final TextEditingController luggageCapacityController = TextEditingController();
  late List<Car> _cars;
  bool _isAddingCar = false; // Flag to prevent multiple submissions

  @override
  void initState() {
    super.initState();
    _cars = widget.carService.getAllCars();
  }

  void _addCar() async {
    if (_isAddingCar) return; // Prevent multiple submissions
    setState(() {
      _isAddingCar = true;
    });

    final currentUser = widget.authService.getCurrentUser();
    if (currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
      return;
    }

    final carName = carNameController.text;
    final brand = brandController.text;
    final price = double.tryParse(priceController.text) ?? 0;
    final description = descriptionController.text;
    final model = modelController.text;
    final imageData = imageDataController.text;
    final passengers = int.tryParse(passengersController.text) ?? 0;
    final luggageCapacity = int.tryParse(luggageCapacityController.text) ?? 0;

    if (carName.isEmpty || brand.isEmpty || price <= 0 || description.isEmpty || model.isEmpty || imageData.isEmpty || passengers <= 0 || luggageCapacity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields')),
      );
      setState(() {
        _isAddingCar = false;
      });
      return;
    }

    try {
      final newCar = Car(
        id: DateTime.now().millisecondsSinceEpoch,
        passengers: passengers,
        luggageCapacity: luggageCapacity,
        carName: carName,
        brand: brand,
        carPrice: price,
        carDescription: description,
        carModel: model,
        imageData: imageData,
        isAvailable: true,
      );
      setState(() {
        _cars.add(newCar);
        _isAddingCar = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LywNavigator()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add car')),
      );
      setState(() {
        _isAddingCar = false;
      });
    }
  }

  @override
  void dispose() {
    carNameController.dispose();
    brandController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    modelController.dispose();
    imageDataController.dispose();
    passengersController.dispose();
    luggageCapacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: carNameController,
              decoration: const InputDecoration(labelText: 'Car Name'),
            ),
            TextField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: imageDataController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: passengersController,
              decoration: const InputDecoration(labelText: 'Passengers'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: luggageCapacityController,
              decoration: const InputDecoration(labelText: 'Luggage Capacity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isAddingCar ? null : _addCar, // Disable button while adding
              child: const Text('Add Car'),
            ),
          ],
        ),
      ),
    );
  }
}