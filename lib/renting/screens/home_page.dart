import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/screens/search_page.dart';

class HomePage extends StatefulWidget {
  final void Function(String) onBrandSelected;

  const HomePage({Key? key, required this.onBrandSelected}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showBackButton = false;

  void _onBrandSelected(String brand) {
    widget.onBrandSelected(brand);
    setState(() {
      _showBackButton = true;
    });
  }

  void _onBackButtonPressed() {
    setState(() {
      _showBackButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showBackButton
          ? AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _onBackButtonPressed,
        ),
      )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Drive in style",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              "You want it you got it",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              "Popular Brands",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ChoiceChip(
                    label: const Text("Toyota"),
                    selected: false,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("Toyota");
                    },
                  ),
                  ChoiceChip(
                    label: const Text("BMW"),
                    selected: false,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("BMW");
                    },
                  ),
                  ChoiceChip(
                    label: const Text("Jeep"),
                    selected: false,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("Jeep");
                    },
                  ),
                  ChoiceChip(
                    label: const Text("Ford"),
                    selected: false,
                    backgroundColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (bool selected) {
                      _onBrandSelected("Ford");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: SearchPage(selectedBrand: '')),
          ],
        ),
      ),
    );
  }
}