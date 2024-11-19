import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';

class User {
   int id;
   String email;
   String password;
   bool isLandlord;
   String name;
   String lastName; // Nuevo campo
   String? bio;
   String? profilePictureUrl;
   String cellphone; // Nuevo campo
   List<Reservation> reservations;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.isLandlord,
    required this.name,
    required this.lastName, // Inicializado
    this.bio,
    this.profilePictureUrl,
    required this.cellphone, // Inicializado
    List<Reservation>? reservations,
  }) : reservations = reservations ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'isLandlord': isLandlord,
      'name': name,
      'lastName': lastName, // Añadido
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'cellphone': cellphone, // Añadido
      'reservations': reservations.map((reservation) => reservation.toJson())
          .toList(),
    };
  }}