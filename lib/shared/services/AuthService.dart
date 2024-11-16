import 'dart:ffi';

import 'package:app_tentify_frfr/shared/models/reservation.dart';
import 'package:app_tentify_frfr/shared/models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final List<User> _users = [];
  int _nextId = 2;
  User? _currentUser;
  static int _nextReservationId = 2;

  factory AuthService() {
    return _instance;
  }

  AuthService._internal() {
    _users.add(User(
      id: 1,
      email: 'cano@gmail.com',
      password: 'hola',
      isLandlord: false, // Default value
      name: 'Diego Cano',
      bio: 'Hello, I am Cano and I love partying all night.',
      profilePictureUrl: 'https://m.media-amazon.com/images/M/MV5BNTE1ODU3NTM1N15BMl5BanBnXkFtZTcwNTk0NDM4Nw@@._V1_.jpg',
    ));
  }

  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _users.firstWhere(
          (user) => user.email == email,
      orElse: () => null as User,
    );
    if (user == null) {
      return 'Email not registered';
    } else if (user.password != password) {
      return 'Incorrect password';
    }
    _currentUser = user;
    return 'Success';
  }

  User? getCurrentUser() {
    return _currentUser;
  }

  Future<String> signup(String email, String password, bool isLandlord) async {
    if (_users.any((existingUser) => existingUser.email == email)) {
      return 'Email already exists';
    }
    User newUser = User(
      id: _nextId,
      email: email,
      password: password,
      isLandlord: isLandlord, // Assign the new field
    );
    _users.add(newUser);
    _nextId++;
    return 'User registered successfully';
  }

  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _users.indexWhere((existingUser) => existingUser.id == user.id);
    if (index != -1) {
      _users[index] = user;
    } else {
      throw Exception('User with id ${user.id} not found');
    }
  }

  Future<void> addReservationToCurrentUser(Reservation reservation) async {
    if (_currentUser == null) {
      throw Exception('No current user logged in');
    }
    if (_currentUser!.reservations == null) {
      _currentUser!.reservations = [];
    }
    reservation.id = _nextReservationId;
    _nextReservationId++;
    _currentUser!.reservations!.add(reservation);
    await updateUser(_currentUser!);
  }
}