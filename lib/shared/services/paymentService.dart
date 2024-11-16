
import 'package:app_tentify_frfr/shared/models/paymentmethod.dart';

class PaymentMethodService {
  static final PaymentMethodService _instance = PaymentMethodService._internal();
  List<PaymentMethod> _paymentMethods = [];

  factory PaymentMethodService() {
    return _instance;
  }

  PaymentMethodService._internal(){
    _paymentMethods.add(PaymentMethod(
      id: 1,
      type: 'Credit Card',
      cardNumber: '1234 5678 9012 3456',
      expiryDate: '12/23',
      cardHolderName: 'Diego Canin',
      userId: 1,
    ));
  }

  List<PaymentMethod> getAllPaymentMethods() {
    return _paymentMethods;
  }

  void addPaymentMethod(PaymentMethod paymentMethod) {
    _paymentMethods.add(paymentMethod);
  }

  void removePaymentMethod(int id) {
    _paymentMethods.removeWhere((paymentMethod) => paymentMethod.id == id);
  }

  void updatePaymentMethod(PaymentMethod updatedPaymentMethod) {
    final index = _paymentMethods.indexWhere((paymentMethod) => paymentMethod.id == updatedPaymentMethod.id);
    if (index != -1) {
      _paymentMethods[index] = updatedPaymentMethod;
    } else {
      throw Exception('Payment method with id ${updatedPaymentMethod.id} not found');
    }
  }
  List<PaymentMethod> getAllPaymentMethodsByUser(int userId) {
    return _paymentMethods.where((paymentMethod) => paymentMethod.userId == userId).toList();
  }
}