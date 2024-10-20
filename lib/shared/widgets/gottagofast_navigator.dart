import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/screens/home_page.dart';
import 'package:lead_your_way/renting/screens/profile_page.dart';
import 'package:lead_your_way/renting/screens/search_page.dart';
import 'package:lead_your_way/routes/app_route.dart';
import 'package:lead_your_way/shared/widgets/gottagofast_bottom_navigation.dart';
import 'package:lead_your_way/shared/services/carsService.dart';

class LywNavigator extends StatefulWidget {
  const LywNavigator({super.key});

  @override
  State<LywNavigator> createState() => _LywNavigatorState();
}

class _LywNavigatorState extends State<LywNavigator> {
  late Widget currentView;
  String selectedBrand = '';
  double selectedBudget = 0;
  final CarService carService = CarService();

  @override
  void initState() {
    super.initState();
    currentView = HomePage(onBrandSelected: _onBrandSelected, onBudgetSelected: _onBudgetSelected);
  }

  void _onTabTapped(AppRoute route) {
    setState(() {
      switch(route) {
        case AppRoute.home:
          currentView = HomePage(onBrandSelected: _onBrandSelected, onBudgetSelected: _onBudgetSelected);
          break;
        case AppRoute.profile:
          currentView = const ProfilePage();
          break;
        case AppRoute.search:
          currentView = SearchPage(
            selectedBrand: selectedBrand,
            selectedBudget: selectedBudget,
            showAll: true,
            carService: carService,
          );
          break;
        case AppRoute.favorite:
          currentView = SearchPage(
            selectedBrand: selectedBrand,
            selectedBudget: selectedBudget,
            carService: carService,
          );
          break;
      }
    });
  }

  void _onBrandSelected(String brand) {
    setState(() {
      selectedBrand = brand;
      currentView = SearchPage(
        selectedBrand: selectedBrand,
        selectedBudget: selectedBudget,
        carService: carService,
      );
    });
  }

  void _onBudgetSelected(double budget) {
    setState(() {
      selectedBudget = budget;
      currentView = SearchPage(
        selectedBrand: '',
        selectedBudget: selectedBudget,
        showAll: false,
        carService: carService,
      );
    });
  }

  void _onBackButtonPressed() {
    setState(() {
      selectedBrand = '';
      selectedBudget = 0;
      currentView = HomePage(
        onBrandSelected: _onBrandSelected,
        onBudgetSelected: _onBudgetSelected,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackButtonPressed();
        return false;
      },
      child: Scaffold(
        body: Center(child: currentView),
        bottomNavigationBar: LywBottomNavigation(onNavigationChange: _onTabTapped),
      ),
    );
  }
}