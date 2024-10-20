import 'package:lead_your_way/shared/models/car.dart';

class User {
  String id;
  String email;
  String password;
  String? name;
  String? bio;
  String? profilePictureUrl;
  List<Car>? cars;

  User({
    required this.id,
    required this.email,
    required this.password,
    this.name,
    this.bio,
    this.profilePictureUrl,
    this.cars,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'cars': cars?.map((car) => car.toJson()).toList(),
    };
  }
}