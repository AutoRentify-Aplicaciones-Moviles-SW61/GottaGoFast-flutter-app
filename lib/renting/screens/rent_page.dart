import 'package:flutter/material.dart';
import 'package:lead_your_way/shared/models/car.dart';

class RentPage extends StatelessWidget {
  const RentPage({super.key, required this.car});
  final Car car;

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      car.imageData,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error, size: 100); // Error handling for image
      },
    );
    final dailyPrice = car.carPrice / 30; // Assuming 30-day rental period

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 220.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.blueAccent,
              flexibleSpace: FlexibleSpaceBar(
                background: image,
                title: Text(
                  car.carModel,
                  style: const TextStyle(shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ]),
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.carName,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                car.carDescription,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price: \$${dailyPrice.toStringAsFixed(2)} / day',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Brand: ${car.brand}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 1.5),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pickup Location:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tampa Airport',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Pickup Date:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Oct 24, 2024, 12:00 PM',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Dropoff Location:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tampa Airport',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Dropoff Date:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Oct 28, 2024, 12:00 PM',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 20, thickness: 1.5),
              const SizedBox(height: 16),
              const Text(
                'Total Charges',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rental Rate: \$${(dailyPrice * 4).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Text(
                        'Surcharge: \$8.00',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        'Sales Tax: \$5.24',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Total: \$87.59 USD',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Button color
                      ),
                      onPressed: () {
                        // Add rent action
                      },
                      child: const Text(
                        'Rent Now',
                        style: TextStyle(fontSize: 18),

                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
