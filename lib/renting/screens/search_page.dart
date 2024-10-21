import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/screens/rent_page.dart';
import 'package:lead_your_way/shared/models/car.dart';
import '../../shared/services/carsService.dart';
import '../widgets/car_card.dart';


class SearchPage extends StatefulWidget {
  final String selectedBrand;
  final double selectedBudget;
  final bool showAll;
  final CarService carService;

  const SearchPage({
    super.key,
    required this.selectedBrand,
    this.selectedBudget = 0,
    this.showAll = false,
    required this.carService,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Car> allCars = widget.carService.getAllCars();
    List<Car> filteredCars = widget.showAll
        ? allCars
        : allCars.where((car) {
      return (widget.selectedBrand.isEmpty || car.brand == widget.selectedBrand) &&
          (widget.selectedBudget == 0 || car.carPrice <= widget.selectedBudget);
    }).toList();

    if (searchQuery.isNotEmpty) {
      filteredCars = filteredCars.where((car) => car.carName.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Results'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (Car car in filteredCars)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RentPage (car: car),
                        ),
                      );
                    },
                    child: CarCard(car: car),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}