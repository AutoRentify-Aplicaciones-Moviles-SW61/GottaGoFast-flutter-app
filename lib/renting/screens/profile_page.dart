import 'package:flutter/material.dart';
import 'package:lead_your_way/shared/models/car.dart';
import 'package:lead_your_way/shared/models/user.dart';
import 'package:lead_your_way/shared/services/authService.dart';
import 'package:lead_your_way/renting/widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MockAuthService _authService = MockAuthService();
  User? _currentUser;
  List<Car> _reservedCars = [];

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.getCurrentUser();
    _reservedCars = _authService.getReservedCars();
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
      ],
    ),
  );

  Widget buildReservedCars() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reserved cars",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _reservedCars.isEmpty
            ? const Text("No reserved cars available.")
            : Column(
          children: _reservedCars.map((car) => ListTile(
            title: Text(car.carName),
            subtitle: Text(car.carModel),
            leading: Image.network(car.imageData, width: 50, height: 50, fit: BoxFit.cover),
          )).toList(),
        ),
      ],
    ),
  );
}