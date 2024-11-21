import 'dart:convert';
import 'package:app_tentify_frfr/core/app_constants.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:app_tentify_frfr/shared/models/reservation.dart';
import 'package:app_tentify_frfr/shared/models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  User? _currentUser;
  String? _token;
  static int _nextReservationId = 2;

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();


  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Gmail': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      _token = jsonDecode(response.body);

      final usersResponse = await http.get(
        Uri.parse('${AppConstants.baseUrl}/api/user'),
        headers: <String, String>{
          'Authorization': 'Bearer $_token',
        },
      );

      if (usersResponse.statusCode == 200) {
        final List<dynamic> usersList = jsonDecode(usersResponse.body);
        final currentUserData = usersList.firstWhere(
              (user) => user['Gmail'] == email,
          orElse: () => null,
        );

        if (currentUserData != null) {
          _currentUser = User(
            id: currentUserData['Id'],
            email: currentUserData['Gmail'],
            password: 'Password',
            isLandlord: currentUserData['isLandlord'] ?? false,
            name: currentUserData['Name'],
            lastName: currentUserData['LastName'] ?? '',
            bio: currentUserData['Bio'],
            profilePictureUrl: currentUserData['profilePictureUrl'],
            cellphone: currentUserData['cellphone'] ?? '',
            reservations: [], // Ajustar si es necesario
          );

          return 'Login successful';
        } else {
          return 'User not found after login';
        }
      } else {
        return 'Failed to fetch users: ${usersResponse.statusCode} - ${usersResponse.reasonPhrase}';
      }
    } else if (response.statusCode == 401) {
      return 'Unauthorized: Incorrect email or password';
    } else {
      return 'Failed to login: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }


  User? getCurrentUser() {
    return _currentUser;
  }

  Future<String> signup(String name, String lastName, String cellphone, String email, String password) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Name': name,
        'LastName': lastName,
        'Cellphone': cellphone,
        'Gmail': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      return 'User registered successfully';
    } else {
      return 'Failed to register: ${response.body}';
    }
  }

  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('${AppConstants.baseUrl}/api/user/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        if (_token != null) 'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(user.toJson()),
    );

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