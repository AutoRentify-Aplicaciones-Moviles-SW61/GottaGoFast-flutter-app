import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/models/user.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/renting/screens/payment_page.dart';

class ReservationFormPage extends StatefulWidget {
  final Car car;
  final AuthService authService;

  const ReservationFormPage({
    Key? key,
    required this.car,
    required this.authService,
  }) : super(key: key);

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _pickupLocationController = TextEditingController();
  final _dropoffLocationController = TextEditingController();
  DateTime? _pickupDate;
  DateTime? _dropoffDate;

  User? getCurrentUser() {
    return widget.authService.getCurrentUser();
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          _pickupDate = picked;
        } else {
          _dropoffDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve ${widget.car.carName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pickupLocationController,
                decoration: const InputDecoration(labelText: 'Pickup Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a pickup location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dropoffLocationController,
                decoration: const InputDecoration(labelText: 'Dropoff Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dropoff location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  _pickupDate == null
                      ? 'Select Pickup Date'
                      : 'Pickup Date: ${_pickupDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              ListTile(
                title: Text(
                  _dropoffDate == null
                      ? 'Select Dropoff Date'
                      : 'Dropoff Date: ${_dropoffDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _pickupDate != null &&
                      _dropoffDate != null &&
                      _pickupDate!.isBefore(_dropoffDate!)) {
                    final reservation = Reservation(
                      id: 0,
                      vehicleId: widget.car.id,
                      pickupLocation: _pickupLocationController.text,
                      dropoffLocation: _dropoffLocationController.text,
                      pickupDate: _pickupDate!,
                      dropoffDate: _dropoffDate!,
                      rentalRate: widget.car.carPrice,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          reservation: reservation,
                          car: widget.car,
                          authService: widget.authService,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields and ensure dates are valid')),
                    );
                  }
                },
                child: const Text('Rent Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}