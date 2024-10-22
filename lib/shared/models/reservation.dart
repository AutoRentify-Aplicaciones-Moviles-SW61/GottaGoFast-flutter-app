class Reservation {
  int id; // Cambiado de String a int
  final int vehicleId;
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime pickupDate;
  final DateTime dropoffDate;
  final double rentalRate;
  late final double surcharge;
  late final double salesTax;
  late final double totalPrice;

  Reservation({
    required this.id,
    required this.vehicleId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDate,
    required this.dropoffDate,
    required this.rentalRate,
  }) {
    totalPrice = _calculateTotalPrice();
  }

  double _calculateTotalPrice() {
    final int rentalDays = dropoffDate.difference(pickupDate).inDays;
    final double rentalCost = rentalRate * rentalDays;
    surcharge = rentalCost * 0.05;
    salesTax = rentalCost * 0.18;
    return rentalCost + surcharge + salesTax;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'pickupDate': pickupDate.toIso8601String(),
      'dropoffDate': dropoffDate.toIso8601String(),
      'rentalRate': rentalRate,
      'surcharge': surcharge,
      'salesTax': salesTax,
      'totalPrice': totalPrice,
    };
  }
}