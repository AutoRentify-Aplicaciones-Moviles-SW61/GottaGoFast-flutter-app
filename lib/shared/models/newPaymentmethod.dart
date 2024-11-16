import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/paymentmethod.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/paymentService.dart';

class NewPaymentMethodPage extends StatefulWidget {
  final AuthService authService;

  const NewPaymentMethodPage({Key? key, required this.authService}) : super(key: key);

  @override
  _NewPaymentMethodPageState createState() => _NewPaymentMethodPageState();
}

class _NewPaymentMethodPageState extends State<NewPaymentMethodPage> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cardHolderNameController = TextEditingController();

  void _addPaymentMethod() {
    if (_formKey.currentState!.validate()) {
      final currentUser = widget.authService.getCurrentUser();
      if (currentUser != null) {
        final newPaymentMethod = PaymentMethod(
          id: DateTime.now().millisecondsSinceEpoch,
          type: _typeController.text,
          cardNumber: _cardNumberController.text,
          expiryDate: _expiryDateController.text,
          cardHolderName: _cardHolderNameController.text,
          userId: currentUser.id,
        );
        PaymentMethodService().addPaymentMethod(newPaymentMethod);
        Navigator.pop(context, newPaymentMethod);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: const InputDecoration(labelText: 'Card Holder Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the card holder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPaymentMethod,
                child: const Text('Add Payment Method'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}