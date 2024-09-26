import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/screens/home_page.dart';
import 'package:lead_your_way/renting/screens/profile_page.dart';
import 'package:lead_your_way/renting/screens/search_page.dart';
import 'package:lead_your_way/routes/app_route.dart';
import 'package:lead_your_way/shared/widgets/gottagofast_bottom_navigation.dart';

class LywNavigator extends StatefulWidget {
  const LywNavigator({super.key});

  @override
  State<LywNavigator> createState() => _LywNavigatorState();
}

class _LywNavigatorState extends State<LywNavigator> {
  Widget currentView = const HomePage();

  void _onTabTapped(AppRoute route) {
    setState(() {
      switch(route) {
        case AppRoute.home: currentView = const HomePage();
        case AppRoute.profile: currentView = const ProfilePage();
        case AppRoute.search: currentView = const SearchPage();
        case AppRoute.favorite: currentView = const SearchPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: currentView),
      bottomNavigationBar: LywBottomNavigation(onNavigationChange: _onTabTapped),
    );
  }
}
