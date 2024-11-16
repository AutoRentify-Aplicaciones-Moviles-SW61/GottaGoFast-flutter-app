import 'package:app_tentify_frfr/shared/models/car.dart';

class CarService {
  static final CarService _instance = CarService._internal();
  List<Car> _cars = [
    // Carros originales
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
      imageData: "https://fuelcarmagazine.com/wp-content/uploads/2024/03/H2.jpg",
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
      imageData: "https://www.bmw.com.pe/content/dam/bmw/common/all-models/m-series/bmw-z4-m40i/2019/Highlights/bmw-zseries-z4-highlights-next-page-teaser-01.jpg",
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
      imageData: "https://di-uploads-pod21.dealerinspire.com/subaruofpembrokepines/uploads/2023/11/mlp-img-ext-2024-outback.jpg",
      isAvailable: true,
    ),
    Car(
      id: 14,
      passengers: 4,
      luggageCapacity: 3,
      carName: "Tiguan",
      brand: "Volkswagen",
      carPrice: 140.99,
      carDescription: "Compact SUV with modern features for urban driving.",
      carModel: "2024 Model",
      imageData: "https://cdn.motor1.com/images/mgl/zx98j6/s3/2024-vw-tiguan-rendering.jpg",
      isAvailable: true,
    ),
    Car(
      id: 15,
      passengers: 2,
      luggageCapacity: 1,
      carName: "911 Carrera",
      brand: "Porsche",
      carPrice: 600.00,
      carDescription: "Iconic sports car known for its performance and design.",
      carModel: "2025 Model",
      imageData: "https://acnews.blob.core.windows.net/imgnews/medium/NAZ_8b98a8584eba40e889b4d0cc54d5b23d.webp",
      isAvailable: true,
    ),
    Car(
      id: 16,
      passengers: 5,
      luggageCapacity: 3,
      carName: "Accord",
      brand: "Honda",
      carPrice: 115.75,
      carDescription: "A reliable and fuel-efficient sedan for everyday driving.",
      carModel: "2024 Model",
      imageData: "https://img.sm360.ca/images/article/dilawri-group-of-companies/129584//exterior-11718401961396.jpg",
      isAvailable: true,
    ),
    Car(
      id: 17,
      passengers: 5,
      luggageCapacity: 2,
      carName: "A6",
      brand: "Audi",
      carPrice: 350.00,
      carDescription: "Premium executive sedan with advanced technology.",
      carModel: "2024 Model",
      imageData: "https://pictures.dealer.com/b/beechmontaudiaoa/0818/5e71924d987593425fe10a41c667d7cex.jpg?impolicy=downsize_bkpt&w=410",
      isAvailable: true,
    ),
    Car(
      id: 18,
      passengers: 5,
      luggageCapacity: 2,
      carName: "CX-5",
      brand: "Mazda",
      carPrice: 130.99,
      carDescription: "Sporty SUV with sleek design and excellent handling.",
      carModel: "2024 Model",
      imageData: "https://www.mazda.ca/globalassets/mazda-canada/vehicles/2024/cx-5/2024-cx5-c22-hero-dt.jpg",
      isAvailable: true,
    ),
    Car(
      id: 19,
      passengers: 7,
      luggageCapacity: 6,
      carName: "Tahoe",
      brand: "Chevrolet",
      carPrice: 180.00,
      carDescription: "Spacious SUV with premium features and powerful engine.",
      carModel: "2024 Model",
      imageData: "https://di-uploads-pod25.dealerinspire.com/rickhendrickcitychevy/uploads/2023/11/mlp-img-ext-2024-tahoe.jpg",
      isAvailable: true,
    ),
    Car(
      id: 20,
      passengers: 2,
      luggageCapacity: 1,
      carName: "MX-5",
      brand: "Mazda",
      carPrice: 210.99,
      carDescription: "Compact roadster with outstanding driving dynamics.",
      carModel: "2025 Model",
      imageData: "https://di-uploads-pod40.dealerinspire.com/kennyrossmazda/uploads/2023/11/Kenny-Ross-Mazda-MX5-Miata.jpeg",
      isAvailable: true,
    ),
  ];

  factory CarService() {
    return _instance;
  }

  CarService._internal();

  List<Car> getAllCars() {
    return _cars;
  }

  List<Car> getAvailableCars() {
    return _cars.where((car) => car.isAvailable).toList();
  }

  void addCar(Car car) {
    _cars.add(car);
  }

  void removeCar(int id) {
    _cars.removeWhere((car) => car.id == id);
  }

  void updateCar(Car updatedCar) {
    final index = _cars.indexWhere((car) => car.id == updatedCar.id);
    if (index != -1) {
      _cars[index] = updatedCar;
    } else {
      throw Exception('Car with id ${updatedCar.id} not found');
    }
  }

  void updateCarAvailability(int carId, bool isAvailable) {
    final car = _cars.firstWhere(
          (car) => car.id == carId,
      orElse: () => Car(
        id: 0,
        passengers: 0,
        luggageCapacity: 0,
        carName: 'Unknown',
        brand: 'Unknown',
        carPrice: 0.0,
        carDescription: 'Unknown',
        carModel: 'Unknown',
        imageData: 'https://via.placeholder.com/50',
        isAvailable: false,
      ),
    );
    car.isAvailable = isAvailable;
  }
}