import 'package:flutter/material.dart';
import 'package:lead_your_way/shared/models/car.dart';
import 'package:lead_your_way/shared/models/reservation.dart';
import 'package:lead_your_way/shared/services/authService.dart';
import 'package:lead_your_way/shared/services/carsService.dart';
import 'package:lead_your_way/shared/services/rentalService.dart';

class ReservationFormPage extends StatefulWidget {
  const ReservationFormPage({super.key, required this.car});
  final Car car;

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _pickupLocationController = TextEditingController();
  final _dropoffLocationController = TextEditingController();
  final _pickupDateController = TextEditingController();
  final _dropoffDateController = TextEditingController();

  @override
  void dispose() {
    _pickupLocationController.dispose();
    _dropoffLocationController.dispose();
    _pickupDateController.dispose();
    _dropoffDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = MockAuthService();
    final reservationService = ReservationService();
    final carService = CarService();
    final currentUser = authService.getCurrentUser();
    final car = widget.car;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Reservation Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _pickupLocationController,
                label: 'Pickup Location',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a pickup location';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _dropoffLocationController,
                label: 'Dropoff Location',
                icon: Icons.location_off,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dropoff location';
                  }
                  return null;
                },
              ),
              _buildDateField(
                controller: _pickupDateController,
                label: 'Pickup Date',
                icon: Icons.date_range,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a pickup date';
                  }
                  try {
                    DateTime.parse(value);
                  } catch (e) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
              ),
              _buildDateField(
                controller: _dropoffDateController,
                label: 'Dropoff Date',
                icon: Icons.date_range,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dropoff date';
                  }
                  try {
                    DateTime.parse(value);
                  } catch (e) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final reservation = Reservation(
                        userId: currentUser!.id,
                        vehicleId: car.id.toString(),
                        pickupLocation: _pickupLocationController.text,
                        dropoffLocation: _dropoffLocationController.text,
                        pickupDate: DateTime.parse(_pickupDateController.text),
                        dropoffDate: DateTime.parse(_dropoffDateController.text),
                        rentalRate: car.carPrice,
                      );
                      reservationService.addReservation(reservation);
                      await authService.addCarToCurrentUser(car);
                      carService.removeCar(car);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Car added to your rentals!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('RENT'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validator,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            controller.text = pickedDate.toIso8601String().split('T').first;
          }
        },
      ),
    );
  }
}