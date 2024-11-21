import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/search_page.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import '../widgets/car_card.dart';

class HomePage extends StatefulWidget {
  final void Function(String) onBrandSelected;
  final void Function(double) onBudgetSelected;

  const HomePage({Key? key, required this.onBrandSelected, required this.onBudgetSelected}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showBackButton = false;
  String selectedBrand = '';
  double selectedBudget = 0;

void _onBrandSelected(String brand) {
  widget.onBrandSelected(brand);
  setState(() {
    selectedBrand = brand == "All" ? '' : brand; // Si se selecciona "All", limpiar el filtro de marca.
    _showBackButton = true;
  });
}

  void _onBudgetSelected(double budget) {
    widget.onBudgetSelected(budget);
    setState(() {
      selectedBudget = budget;
      _showBackButton = true;
    });
  }

  void _onBackButtonPressed() {
    widget.onBrandSelected('');
    widget.onBudgetSelected(0);
    setState(() {
      _showBackButton = false;
      selectedBrand = '';
      selectedBudget = 0;
    });
    Navigator.of(context).pop(); // Asegúrate de que esto navegue correctamente
  }

  @override
  Widget build(BuildContext context) {
    List<Car> hardcodedCars = [
      Car(
        id: 1,
        passengers: 4,
        luggageCapacity: 2,
        carName: "Corolla",
        brand: "Toyota",
        carPrice: 50,
        carDescription: "The Toyota Corolla is a line of subcompact and compact cars manufactured by Toyota.",
        carModel: "2025 Model",
        imageData: "https://di-uploads-pod40.dealerinspire.com/kennyrossmazda/uploads/2023/11/Kenny-Ross-Mazda-MX5-Miata.jpeg",
        isAvailable: true,
      ),
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
        isAvailable: true,
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
        imageData: "https://upload.wikimedia.org/wikipedia/commons/9/91/Opel_Speedster_Blue.jpg",
        isAvailable: true,
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
        isAvailable: true,
      ),
      Car(
        id: 4,
        passengers: 5,
        luggageCapacity: 2,
        carName: "Territory Titanium",
        brand: "Ford",
        carPrice: 80.99,
        carDescription: "A stylish and practical familiar bunker.",
        carModel: "2025 Model",
        imageData: "https://lacochera.net/wp-content/uploads/2024/05/Ford_Territory_2025_China_LaCochera_02-1024x683.webp",
        isAvailable: true,
      ),
      Car(
        id: 5,
        passengers: 5,
        luggageCapacity: 4,
        carName: "Fusion",
        brand: "Ford",
        carPrice: 109.99,
        carDescription: "A high-performance sedan, perfect for long-distance travel.",
        carModel: "2023 Model",
        imageData: "https://img.remediosdigitales.com/5c88ed/mondeo1/1366_2000.jpeg",
        isAvailable: true,
      ),
      Car(
        id: 6,
        passengers: 4,
        luggageCapacity: 3,
        carName: "Eco Sport",
        brand: "Ford",
        carPrice: 130.50,
        carDescription: "Compact crossover SUV, great for city and country driving.",
        carModel: "2024 Model",
        imageData: "https://cdn.motor1.com/images/mgl/wB7XE/s1/lanzamiento-ford-ecosport-made-in-india.webp",
        isAvailable: true,
      ),
      Car(
        id: 7,
        passengers: 8,
        luggageCapacity: 6,
        carName: "Navigator",
        brand: "Lincoln",
        carPrice: 500.00,
        carDescription: "Full-size luxury SUV with all the modern comforts.",
        carModel: "2025 Model",
        imageData: "https://media.architecturaldigest.com/photos/66be68e09101522efce0e118/1:1/w_2250,h_2250,c_limit/2025%20Lincoln%20Navigator%20L%20Black%20Label_Crystal%20White_05.jpg",
        isAvailable: true,
      ),
      Car(
        id: 8,
        passengers: 2,
        luggageCapacity: 1,
        carName: "Convertible Z4",
        brand: "BMW",
        carPrice: 350.99,
        carDescription: "A stylish and agile convertible for sunny road trips.",
        carModel: "2024 Model",
        imageData: "https://hips.hearstapps.com/hmg-prod/images/2025-bmw-z4-m40i-6mt-251-66f43f8382990.jpg?crop=0.637xw:0.477xh;0.114xw,0.380xh&resize=1200:*",
        isAvailable: true,
      ),
      Car(
        id: 9,
        passengers: 7,
        luggageCapacity: 5,
        carName: "Land Cruiser",
        brand: "Toyota",
        carPrice: 180.75,
        carDescription: "Legendary off-road vehicle, designed for extreme adventures.",
        carModel: "2023 Model",
        imageData: "https://i.ytimg.com/vi/QlvTfBEhZPA/maxresdefault.jpg",
        isAvailable: true,
      ),
      Car(
        id: 10,
        passengers: 4,
        luggageCapacity: 4,
        carName: "Cayenne",
        brand: "Porsche",
        carPrice: 420.00,
        carDescription: "High-performance luxury SUV for those who seek speed and style.",
        carModel: "2024 Model",
        imageData: "https://www.rutamotor.com/wp-content/uploads/2023/04/2024-Porsche-Cayenne-31.webp",
        isAvailable: true,
      ),
      Car(
        id: 11,
        passengers: 4,
        luggageCapacity: 2,
        carName: "Model 3",
        brand: "Tesla",
        carPrice: 300.00,
        carDescription: "An electric sedan that combines performance with eco-friendliness.",
        carModel: "2024 Model",
        imageData: "https://www.hibridosyelectricos.com/uploads/s1/73/81/61/tesla-model-3-1.jpeg",
        isAvailable: true,
      ),
      Car(
        id: 12,
        passengers: 7,
        luggageCapacity: 5,
        carName: "Suburban",
        brand: "Chevrolet",
        carPrice: 170.50,
        carDescription: "Large SUV with space for all the family and luggage.",
        carModel: "2025 Model",
        imageData: "https://di-uploads-pod9.dealerinspire.com/blossomchevy/uploads/2024/07/2025-Chevy-Suburban-High-Country-Model-Left.jpg",
        isAvailable: true,
      ),
      Car(
        id: 13,
        passengers: 5,
        luggageCapacity: 3,
        carName: "Outback",
        brand: "Subaru",
        carPrice: 110.00,
        carDescription: "Reliable and rugged SUV, ideal for long trips and adventures.",
        carModel: "2024 Model",
        imageData: "https://di-uploads-pod21.dealerinspire.com/subaruofpembrokepines/uploads/2023/11/mlp-img-ext-model-2024-subaru-outback-touring.png",
        isAvailable: true,
      ),
    ];

    // HOLAAAAA
  List<Car> filteredCars = hardcodedCars.where((car) {
  bool matchesBrand = selectedBrand.isEmpty || selectedBrand == 'All' || car.brand == selectedBrand;
  bool matchesBudget = selectedBudget == 0 || car.carPrice <= selectedBudget;
  return matchesBrand && matchesBudget;
  }).toList();

    return Scaffold(
       appBar: AppBar(
        title: const Text('AUTO RENTIFY'),
        backgroundColor: Colors.blueAccent,
        leading: Container(),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown para marca
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Selecciona la marca"),
                DropdownButton<String>(
                  value: selectedBrand.isEmpty ? null : selectedBrand,
                  //cuando selecciono All muestra todos 
                  hint: Text('Marca'),
                  items: ['All','Toyota', 'BMW', 'Jeep', 'Ford', 'Porsche', 'Tesla', 'Mazda', 'Audi', 'Chevrolet', 'Lincoln']
                      .map((brand) {
                        return DropdownMenuItem<String>(
                          value: brand,
                          child: Text(brand),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _onBrandSelected(value);
                    }
                  },
                ),
              ],
            ),

            // Dropdown para presupuesto
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Selecciona el presupuesto máximo"),
                DropdownButton<double>(
                  value: selectedBudget == 0 ? null : selectedBudget,
                  hint: Text('Presupuesto'),
                  items: [0,50, 100, 200, 300, 400, 500]
                      .map((budget) {
                        return DropdownMenuItem<double>(
                          value: budget.toDouble(),
                          child: Text("\$${budget.toString()}"),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _onBudgetSelected(value);
                    }
                  },
                ),
              ],
            ),

            // Espacio entre los filtros y los resultados
            SizedBox(height: 16),

            // Lista de coches filtrados
            Expanded(
              child: ListView.builder(
                itemCount: filteredCars.length,
                itemBuilder: (context, index) {
                  return CarCard(car: filteredCars[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
