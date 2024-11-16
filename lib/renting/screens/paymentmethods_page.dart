import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/newPaymentmethod.dart';
import 'package:app_tentify_frfr/shared/models/paymentmethod.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/paymentService.dart';

class PaymentMethodsPage extends StatefulWidget {
  final AuthService authService;

  const PaymentMethodsPage({Key? key, required this.authService}) : super(key: key);

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  late List<PaymentMethod> _paymentMethods;

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

  void _deletePaymentMethod(int id) {
    setState(() {
      PaymentMethodService().removePaymentMethod(id);
      _fetchPaymentMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final paymentMethod = _paymentMethods[index];
                  return ListTile(
                    title: Text(paymentMethod.type),
                    subtitle: Text('**** **** **** ${paymentMethod.cardNumber.substring(paymentMethod.cardNumber.length - 4)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePaymentMethod(paymentMethod.id),
                    ),
                  );
                },
              ),
            ),
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