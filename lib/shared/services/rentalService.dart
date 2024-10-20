import 'package:lead_your_way/shared/models/reservation.dart';

class ReservationService {
  final List<Reservation> _reservations = [];

  List<Reservation> getAllReservations() {
    return _reservations;
  }

  void addReservation(Reservation reservation) {
    _reservations.add(reservation);
  }

  void removeReservation(Reservation reservation) {
    _reservations.removeWhere((r) => r.userId == reservation.userId && r.vehicleId == reservation.vehicleId);
  }
}