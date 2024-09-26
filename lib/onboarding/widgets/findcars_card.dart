import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FindBikes extends StatefulWidget {
  const FindBikes({ Key? key }) : super(key: key);

  @override
  State<FindBikes> createState() => _FindBikesState();
}

class _FindBikesState extends State<FindBikes> {
  final image = Lottie.network(
    'https://lottie.host/f69b75fd-ac73-4f21-9ed8-6670ec259f2a/k9KZqJhfWu.json'
  );

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Search for Cars ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),
              ),
              SizedBox(width: 8,),
              Text(
                "with Ease",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.blue
                ),
              ),
            ],
          ),
          image,
          const Text(
            "Rent your way to an unforgettable journey.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}