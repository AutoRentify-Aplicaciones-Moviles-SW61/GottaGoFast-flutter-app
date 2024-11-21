import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/models/reservation.dart';

class User {
  int id;
  String email;
  String password;
  bool isLandlord;
  String name;
  String lastName;
  String? bio;
  String? profilePictureUrl;
  int cellphone;
  List<Reservation> reservations;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.isLandlord,
    required this.name,
    required this.lastName,
    this.bio,
    this.profilePictureUrl,
    required this.cellphone,
    List<Reservation>? reservations,
  }) : reservations = reservations ?? [];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Provide a default value if null
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      cellphone: json['cellphone'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      isLandlord: json['isLandlord'] ?? false,
      bio: json['bio'],
      profilePictureUrl: json['profilePictureUrl'],
      reservations: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'LastName': lastName,
      'Cellphone': cellphone,
      'Gmail': email,
      'Password': password,
      'isLandlord': isLandlord,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'reservations': reservations.map((reservation) => reservation.toJson()).toList(),
    };
  }
}