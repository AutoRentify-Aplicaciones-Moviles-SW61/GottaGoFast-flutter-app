import 'package:flutter/material.dart';
import 'package:lead_your_way/renting/screens/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SearchPage()),
    );
  }
}
