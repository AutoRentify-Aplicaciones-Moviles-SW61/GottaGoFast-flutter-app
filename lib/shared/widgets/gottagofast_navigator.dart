import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/home_page.dart';
import 'package:app_tentify_frfr/renting/screens/profile_page.dart';
import 'package:app_tentify_frfr/renting/screens/reservationsHistory_page.dart';
import 'package:app_tentify_frfr/renting/screens/search_page.dart';
import 'package:app_tentify_frfr/routes/app_route.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';
import 'package:app_tentify_frfr/shared/widgets/gottagofast_bottom_navigation.dart';
import 'package:app_tentify_frfr/shared/services/carsService.dart';
import 'package:app_tentify_frfr/renting/screens/add_car_page.dart';

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
  final AuthService authService = AuthService();
  final CommentService commentService = CommentService();
  bool isLandlord = false;

  @override
  void initState() {
    super.initState();
    final currentUser = authService.getCurrentUser();
    if (currentUser != null) {
      isLandlord = currentUser.isLandlord;
      print("User is logged in: ${currentUser.email}");
    } else {
      print("No user is logged in");
    }
    currentView = isLandlord ? const ProfilePage() : HomePage(onBrandSelected: _onBrandSelected, onBudgetSelected: _onBudgetSelected);
  }

  void _onTabTapped(AppRoute route) {
    setState(() {
      if (isLandlord) {
        switch (route) {
          case AppRoute.profile:
            currentView = const ProfilePage();
            break;
          case AppRoute.search:
            currentView = SearchPage(
              selectedBrand: selectedBrand,
              selectedBudget: selectedBudget,
              showAll: true,
              carService: carService,
              authService: authService,
              commentService: commentService,
            );
            break;
          case AppRoute.addCar:
            currentView = AddCarPage(authService: authService, carService: carService);
            break;
          default:
            currentView = const ProfilePage();
            break;
        }
      } else {
        switch (route) {
          case AppRoute.home:
            currentView = HomePage(onBrandSelected: _onBrandSelected, onBudgetSelected: _onBudgetSelected);
            break;
          case AppRoute.search:
            currentView = SearchPage(
              selectedBrand: selectedBrand,
              selectedBudget: selectedBudget,
              showAll: true,
              carService: carService,
              authService: authService,
              commentService: commentService,
            );
            break;
          case AppRoute.reservations:
            currentView = ReservationHistoryPage(carService: carService, commentService: commentService);
            break;
          case AppRoute.profile:
            currentView = const ProfilePage();
            break;
          default:
            currentView = HomePage(onBrandSelected: _onBrandSelected, onBudgetSelected: _onBudgetSelected);
            break;
        }
      }
    });
  }

  void _onBrandSelected(String brand) {
    setState(() {
      selectedBrand = brand;
    });
  }

  void _onBudgetSelected(double budget) {
    setState(() {
      selectedBudget = budget;
    });
  }

  void _onBackButtonPressed() {
    setState(() {
      currentView = isLandlord ? const ProfilePage() : HomePage(onBrandSelected: _onBrandSelected, onBudgetSelected: _onBudgetSelected);
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
        bottomNavigationBar: LywBottomNavigation(
          onNavigationChange: _onTabTapped,
          isLandlord: isLandlord,
        ),
      ),
    );
  }
}