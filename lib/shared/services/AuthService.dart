import 'package:lead_your_way/shared/models/car.dart';
import 'package:lead_your_way/shared/models/reservation.dart';
import 'package:lead_your_way/shared/models/reservation.dart';
import 'package:lead_your_way/shared/models/user.dart';

class MockAuthService {
  static final MockAuthService _instance = MockAuthService._internal();
  final List<User> _users = [];
  int _nextId = 2;
  User? _currentUser;
  static int _nextReservationId = 2;

  factory MockAuthService() {
    return _instance;
  }

  MockAuthService._internal() {
    _users.add(User(
      id: '1',
      email: 'cano@gmail.com',
      password: 'hola',
      name: 'Diego Cano',
      bio: 'Hello, I am Cano and I love partying all night.',
      profilePictureUrl: 'https://m.media-amazon.com/images/M/MV5BNTE1ODU3NTM1N15BMl5BanBnXkFtZTcwNTk0NDM4Nw@@._V1_.jpg',
      reservations: [
        Reservation(
          id: '1',
          vehicleId: 1,
          pickupLocation: 'Location A',
          dropoffLocation: 'Location B',
          pickupDate: DateTime.now(),
          dropoffDate: DateTime.now().add(Duration(days: 3)),
          rentalRate: 100.0,
        ),
      ],
    ));
  }

  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _users.firstWhere(
          (user) => user.email == email,
      orElse: () => User(id: '', email: '', password: ''),
    );

    if (user.id.isEmpty) {
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

  Future<String> signup(String email, String password) async {
    if (_users.any((existingUser) => existingUser.email == email)) {
      return 'Email already exists';
    }

    User newUser = User(
      id: _nextId.toString(),
      email: email,
      password: password,
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
      throw Exception('User not found');
    }
  }
  Future<void> addReservationToUser(User user, Reservation reservation) async {
    if (user.reservations == null) {
      user.reservations = [];
    }
    reservation.id = _nextReservationId.toString(); // Use the static variable
    _nextReservationId += 2; // Increment the static variable by 2
    user.reservations!.add(reservation);
    await updateUser(user);
  }


  List<Reservation> getUserReservations() {
    return _currentUser?.reservations ?? [];
  }



}