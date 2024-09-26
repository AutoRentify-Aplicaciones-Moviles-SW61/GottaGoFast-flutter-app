import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final image = Lottie.network(
      'https://lottie.host/bbea4195-473e-4525-9293-bde815fe6be1/9MgbBrplfl.json'
  );

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome to",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32
            ),
          ),
          const Text(
            "Gotta Go Fast",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.blueAccent
            ),
          ),
          image,
          const Text(
            "Your go-to car rental app for a convenient, efficient, and enjoyable driving experience.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}