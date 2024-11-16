import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/paymentmethods_page.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/models/user.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/carsService.dart';
import 'package:app_tentify_frfr/renting/widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final CarService _carService = CarService();
  User? _currentUser;
  List<Car> _reservedCars = [];

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.getCurrentUser();
    _loadReservedCars();
  }
  void _navigateToPaymentMethods() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentMethodsPage(authService: _authService)),
    );
  }
  void _loadReservedCars() {
    if (_currentUser?.reservations != null) {
      final cars = _carService.getAllCars();
      _reservedCars = _currentUser!.reservations!
          .map((reservation) => cars.firstWhere(
            (car) => car.id == reservation.vehicleId,
        orElse: () => Car(
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
        ),
      ))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Padding(padding: EdgeInsets.all(15.0)),
          ProfilePicture(
            imagePath: _currentUser?.profilePictureUrl ?? '',
            onClick: () async {},
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 32),
          buildAbout(),
          const SizedBox(height: 32),
          buildReservedCars()
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        _currentUser?.name ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(height: 4),
      Text(
        _currentUser?.email ?? '',
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          _currentUser?.bio ?? '',
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: _navigateToPaymentMethods,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              textStyle: const TextStyle(fontSize: 16, color: Colors.black),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Payment Methods', style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
  );

  Widget buildReservedCars() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reservation History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _reservedCars.isEmpty
            ? const Text("No reserved cars available.")
            : Column(
          children: _reservedCars.map((car) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.network(car.imageData, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(
                    car.carName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Model: ${car.carModel}'),
                      Text('Brand: ${car.brand}'),
                      Text('Price: \$${car.carPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}