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
  late Widget currentView;
  String selectedBrand = '';

  @override
  void initState() {
    super.initState();
    currentView = HomePage(onBrandSelected: _onBrandSelected);
  }

  void _onTabTapped(AppRoute route) {
    setState(() {
      switch(route) {
        case AppRoute.home:
          currentView = HomePage(onBrandSelected: _onBrandSelected);
          break;
        case AppRoute.profile:
          currentView = const ProfilePage();
          break;
        case AppRoute.search:
          currentView = SearchPage(selectedBrand: selectedBrand);
          break;
        case AppRoute.favorite:
          currentView = SearchPage(selectedBrand: selectedBrand);
          break;
      }
    });
  }

  void _onBrandSelected(String brand) {
    setState(() {
      selectedBrand = brand;
      currentView = SearchPage(selectedBrand: selectedBrand);
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