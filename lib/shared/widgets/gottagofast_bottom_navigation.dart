import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lead_your_way/routes/app_route.dart';

class LywBottomNavigation extends StatelessWidget {
  final void Function(AppRoute) onNavigationChange;

  const LywBottomNavigation(
    { Key? key, required this.onNavigationChange }
  ) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: GNav(
          backgroundColor: Colors.blueAccent,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white10,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (int index) {
            AppRoute destination = AppRoute.home;

            switch(index) {
              case 0: destination = AppRoute.home;
              case 1: destination = AppRoute.search;
              case 2: destination = AppRoute.favorite;
              case 3: destination = AppRoute.profile;
            }

            onNavigationChange(destination);
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.search,
              text: "Search"
            ),
            GButton(
              icon: Icons.favorite,
              text: "Favorite"
            ),
            GButton(
              icon: Icons.person,
              text: "Profile"
            ),
          ]
        ),
      ),
    );
  }
}