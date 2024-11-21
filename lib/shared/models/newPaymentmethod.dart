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
  String? _selectedType;

  final List<String> _cardTypes = [
    'Credit Card',
    'Debit Card'
  ];

  @override
  void initState() {
    super.initState();
    _expiryDateController.addListener(_formatExpiryDate);
  }

  @override
  void dispose() {
    _expiryDateController.removeListener(_formatExpiryDate);
    _expiryDateController.dispose();
    _typeController.dispose();
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  void _formatExpiryDate() {
    String text = _expiryDateController.text;

    // Remover caracteres no válidos
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Agregar '/' después de los primeros dos dígitos
    if (text.length > 2) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }

    // Limitar a 5 caracteres (MM/YY)
    if (text.length > 5) {
      text = text.substring(0, 5);
    }

    // Actualizar el controlador si el texto ha cambiado
    if (text != _expiryDateController.text) {
      _expiryDateController.value = _expiryDateController.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _addPaymentMethod() {
    if (_formKey.currentState!.validate()) {
      final currentUser = widget.authService.getCurrentUser();
      if (currentUser != null) {
        final newPaymentMethod = PaymentMethod(
          id: DateTime.now().millisecondsSinceEpoch,
          type: _selectedType!,
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
              DropdownButtonFormField(
                value:_selectedType,
                decoration: const InputDecoration(labelText: 'Card Type'),
                items: _cardTypes.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    _selectedType = newvalue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a card type';
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
                decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  }
                  final RegExp regex = RegExp(r'^\d{2}/\d{2}$');
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid expiry date (MM/YY)';
                  }
                  final int month = int.tryParse(value.split('/')[0]) ?? 0;
                  if (month < 1 || month > 12) {
                    return 'Enter a valid month (01-12)';
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
