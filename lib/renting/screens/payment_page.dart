import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/newPaymentmethod.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/paymentService.dart';
import 'package:app_tentify_frfr/shared/models/paymentmethod.dart';


class PaymentPage extends StatefulWidget {
  final Reservation reservation;
  final Car car;
  final AuthService authService;

  const PaymentPage({
    Key? key,
    required this.reservation,
    required this.car,
    required this.authService,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late List<PaymentMethod> _paymentMethods;
  PaymentMethod? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
  }

  void _fetchPaymentMethods() {
    final currentUser = widget.authService.getCurrentUser();
    if (currentUser != null) {
      _paymentMethods = PaymentMethodService().getAllPaymentMethodsByUser(currentUser.id);
    } else {
      _paymentMethods = [];
    }
  }

  void _navigateToAddPaymentMethod() async {
    final newPaymentMethod = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPaymentMethodPage(authService: widget.authService)),
    );
    if (newPaymentMethod != null) {
      setState(() {
        _paymentMethods.add(newPaymentMethod);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Information'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(widget.car.imageData, height: 200, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Text('Car Name: ${widget.car.carName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Model: ${widget.car.carModel}', style: const TextStyle(fontSize: 16)),
            Text('Description: ${widget.car.carDescription}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Reservation Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Pickup Location: ${widget.reservation.pickupLocation}', style: const TextStyle(fontSize: 16)),
            Text('Dropoff Location: ${widget.reservation.dropoffLocation}', style: const TextStyle(fontSize: 16)),
            Text('Pickup Date: ${widget.reservation.pickupDate}', style: const TextStyle(fontSize: 16)),
            Text('Dropoff Date: ${widget.reservation.dropoffDate}', style: const TextStyle(fontSize: 16)),
            Text('Rental Rate: \$${widget.reservation.rentalRate}', style: const TextStyle(fontSize: 16)),
            Text('Total Price: \$${widget.reservation.totalPrice}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Payment Methods:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: _paymentMethods.isEmpty
                  ? const Center(child: Text('No payment methods available'))
                  : ListView.builder(
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final paymentMethod = _paymentMethods[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = paymentMethod;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedPaymentMethod == paymentMethod ? Colors.blue : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: _selectedPaymentMethod == paymentMethod ? Colors.blue.withOpacity(0.1) : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${paymentMethod.type} - ${paymentMethod.cardNumber}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _selectedPaymentMethod == null ? null : () async {
                try {
                  await widget.authService.addReservationToCurrentUser(widget.reservation);
                  setState(() {
                    widget.car.isAvailable = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reservation created')),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to confirm payment: $e')),
                  );
                }
              },
              child: const Text('Confirm Payment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToAddPaymentMethod,
              child: const Text('Add Payment Method'),
            ),
          ],
        ),
      ),
    );
  }
}