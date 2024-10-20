import 'package:flutter/material.dart';
import 'package:lead_your_way/shared/models/user.dart';
import 'package:lead_your_way/shared/services/authService.dart';
import 'package:lead_your_way/renting/widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MockAuthService _authService = MockAuthService();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Padding(padding: EdgeInsets.all(15.0)),
          ProfilePicture(
            imagePath: _currentUser?.profilePictureUrl ?? '',
            onClick: () async {},
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 32),
          buildAbout(),
          const SizedBox(height: 32),
          buildBicycles()
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        _currentUser?.name ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(height: 4),
      Text(
        _currentUser?.email ?? '',
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          _currentUser?.bio ?? '',
        ),
      ],
    ),
  );

  Widget buildBicycles() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reserved cars",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Text(
          "Favorite Reserved Cars",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}