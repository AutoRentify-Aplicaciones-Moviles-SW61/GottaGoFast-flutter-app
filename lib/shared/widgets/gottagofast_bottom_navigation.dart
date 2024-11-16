import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:app_tentify_frfr/routes/app_route.dart';

class LywBottomNavigation extends StatelessWidget {
  final void Function(AppRoute) onNavigationChange;
  final bool isLandlord;

  const LywBottomNavigation({
    Key? key,
    required this.onNavigationChange,
    required this.isLandlord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

            if (isLandlord) {
              switch (index) {
                case 0:
                  destination = AppRoute.profile;
                  break;
                case 1:
                  destination = AppRoute.search;
                  break;
                case 2:
                  destination = AppRoute.addCar;
                  break;
              }
            } else {
              switch (index) {
                case 0:
                  destination = AppRoute.home;
                  break;
                case 1:
                  destination = AppRoute.search;
                  break;
                case 2:
                  destination = AppRoute.reservations;
                  break;
                case 3:
                  destination = AppRoute.profile;
                  break;
              }
            }

            onNavigationChange(destination);
          },
          tabs: isLandlord
              ? [
            const GButton(
              icon: Icons.person,
              text: "Profile",
            ),
            const GButton(
              icon: Icons.search,
              text: "Search",
            ),
            const GButton(
              icon: Icons.add,
              text: "Add Car",
            ),
          ]
              : [
            const GButton(
              icon: Icons.home,
              text: "Home",
            ),
            const GButton(
              icon: Icons.search,
              text: "Search",
            ),
            const GButton(
              icon: Icons.favorite,
              text: "Reservations",
            ),
            const GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}