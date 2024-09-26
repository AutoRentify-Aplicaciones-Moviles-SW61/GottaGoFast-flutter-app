import 'package:flutter/material.dart';
import 'package:lead_your_way/onboarding/widgets/car_card.dart';
import 'package:lead_your_way/shared/models/car.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Car> hardcodedBicycles = [
    Car(
      id: 1,
      passengers: 5,
      luggageCapacity: 3,
      carName: "Luxury Cruiser",
      brand: "Toyota",
      carPrice: 150.00,
      carDescription: "A luxurious and spacious city sedan, perfect for comfortable travel.",
      carModel: "2023 Model",
      imageData: "https://carsguide-res.cloudinary.com/image/upload/c_fit,h_405,w_720,f_auto,t_cg_base/v1/editorial/story%2Fhero_image%2FToyota-FJ-Render-1001x565.jpg",
    ),
    Car(
      id: 2,
      passengers: 2,
      luggageCapacity: 2,
      carName: "Speedster",
      brand: "BMW",
      carPrice: 400.00,
      carDescription: "A sleek and powerful road car for speed enthusiasts.",
      carModel: "2023 Model",
      imageData: "https://fuelcarmagazine.com/wp-content/uploads/2024/03/H2.jpg",
    ),
    Car(
      id: 3,
      passengers: 7,
      luggageCapacity: 5,
      carName: "Grand Cherokee",
      brand: "Jeep",
      carPrice: 149.99,
      carDescription: "An all-terrain SUV perfect for off-road adventures.",
      carModel: "2023 Model",
      imageData: "https://www.jeep.com/content/dam/cross-regional/stellantis/jeep/latam-rol/peru/modelos/2023/grand-cherokee/gch-l/versiones/gch-l-limited-version-model.png.img.2880.png",
    ),
    Car(
      id: 4,
      passengers: 5,
      luggageCapacity: 2,
      carName: "Territory Titanium",
      brand: "Ford",
      carPrice: 80.99,
      carDescription: "A stylish and practical familiar bunker",
      carModel: "2025 Model",
      imageData: "https://lacochera.net/wp-content/uploads/2024/05/Ford_Territory_2025_China_LaCochera_02-1024x683.webp",
    ),
    Car(
      id: 5,
      passengers: 5,
      luggageCapacity: 4,
      carName: "Fusion ",
      brand: "Ford",
      carPrice: 109.99,
      carDescription: "A high-performance sedan, perfect for long-distance travel.",
      carModel: "2023 Model",
      imageData: "https://img.remediosdigitales.com/5c88ed/mondeo1/1366_2000.jpeg",
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            for (Car car in hardcodedBicycles)
              BicycleCard(car: car)
          ],
        ),
      ),
    );
  }
}
