class Car {
  final int id;
  final int passengers;
  final int luggageCapacity;
  final String carName;
  final String brand;
  final double carPrice;
  final String carDescription;
  final String carModel;
  final String imageData;

  Car({
    required this.id,
    required this.passengers,
    required this.luggageCapacity,
    required this.carName,
    required this.brand,
    required this.carPrice,
    required this.carDescription,
    required this.carModel,
    required this.imageData,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        passengers: json["passengers"],
        luggageCapacity: json["luggageCapacity"],
        carName: json["carName"],
        brand: json["brand"],
        carPrice: json["price"],
        carDescription: json ["carDescription"],
        carModel: json["model"],
        imageData: json["imageData"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "passengers": passengers,
        "luggageCapacity": luggageCapacity,
        "carName" : carName,
        "brand": brand,
        "price" : brand,
        "carDescription" : carDescription,
        "model": carModel,
        "imageData": imageData,
      };
}
