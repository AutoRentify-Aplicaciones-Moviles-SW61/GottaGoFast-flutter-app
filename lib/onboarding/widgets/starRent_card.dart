import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartAdventure extends StatefulWidget {
  const StartAdventure({ Key? key }) : super(key: key);

  @override
  State<StartAdventure> createState() => _StartAdventureState();
}

class _StartAdventureState extends State<StartAdventure> {
  final image = Lottie.network(
    'https://lottie.host/22a8acc6-59db-4c11-8c97-37e169d89984/yLCUN91xo3.json'
  );

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Start now ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32
            ),
          ),
          const Text(
            "your trip",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.blue
            ),
          ),
          image,
        ],
      ),
    );  }
}