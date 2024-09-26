import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Padding(padding: EdgeInsets.all(15.0)),
          ProfilePicture(
            imagePath: "https://m.media-amazon.com/images/M/MV5BNTE1ODU3NTM1N15BMl5BanBnXkFtZTcwNTk0NDM4Nw@@._V1_.jpg",
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
      //bottomNavigationBar: const LywBottomNavigation(),
    );
  }

  Widget buildName() => const Column(
    children: [
      Text(
        "Sean John Combs",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 4),
      Text(
        "partyallnight@example.com",
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(
          "This is my description..."
        )
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