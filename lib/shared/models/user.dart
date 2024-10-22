import 'package:lead_your_way/shared/models/car.dart';
import 'package:lead_your_way/shared/models/reservation.dart';

class User {
  int id; // Cambiado de String a int
  String email;
  String password;
  String? name;
  String? bio;
  String? profilePictureUrl;
  List<Reservation>? reservations;

  User({
    required this.id,
    required this.email,
    required this.password,
    this.name,
    this.bio,
    this.profilePictureUrl,
    this.reservations,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'reservations': reservations?.map((reservation) => reservation.toJson()).toList(),
    };
  }
}