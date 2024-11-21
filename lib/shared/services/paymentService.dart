
import 'package:app_tentify_frfr/shared/models/paymentmethod.dart';

class PaymentMethodService {
  static final PaymentMethodService _instance = PaymentMethodService._internal();
  List<PaymentMethod> _paymentMethods = [];

  factory PaymentMethodService() {
    return _instance;
  }

  PaymentMethodService._internal(){
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