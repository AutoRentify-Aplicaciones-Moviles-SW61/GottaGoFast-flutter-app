import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';

class User {
  int id;
  String email;
  String password;
  bool isLandlord; // New boolean field
  String? name;
  String? bio;
  String? profilePictureUrl;
  List<Reservation>? reservations;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.isLandlord, // New required field
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
      'isLandlord': isLandlord, // Include in JSON
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'reservations': reservations?.map((reservation) => reservation.toJson()).toList(),
    };
  }
}