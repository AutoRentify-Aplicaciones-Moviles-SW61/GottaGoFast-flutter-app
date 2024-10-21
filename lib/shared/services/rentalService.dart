import 'package:lead_your_way/shared/models/reservation.dart';

class ReservationService {
  final List<Reservation> _reservations = [];
  int _nextId = 2;

  ReservationService() {
    // Add a default reservation
    final defaultReservation = Reservation(
      id: '1',
      vehicleId: 2,
      pickupLocation: 'Location A',
      dropoffLocation: 'Location B',
      pickupDate: DateTime.now(),
      dropoffDate: DateTime.now().add(Duration(days: 3)),
      rentalRate: 100.0,
    );
    _reservations.add(defaultReservation);
  }

  int get nextId => _nextId;

  void addReservation(Reservation reservation) {
    reservation = Reservation(
      id: _nextId.toString(),
      vehicleId: reservation.vehicleId,
      pickupLocation: reservation.pickupLocation,
      dropoffLocation: reservation.dropoffLocation,
      pickupDate: reservation.pickupDate,
      dropoffDate: reservation.dropoffDate,
      rentalRate: reservation.rentalRate,
    );
    _reservations.add(reservation);
    _nextId++;
  }

  void removeReservation(Reservation reservation) {
    _reservations.removeWhere((r) => r.id == reservation.id);
  }

  List<Reservation> getReservations() {
    return _reservations;
  }
}