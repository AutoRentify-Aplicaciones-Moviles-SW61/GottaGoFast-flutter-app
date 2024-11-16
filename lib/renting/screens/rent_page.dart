import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/comments_page.dart';
import 'package:app_tentify_frfr/renting/screens/reservations_page.dart';
import 'package:app_tentify_frfr/shared/models/car.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';

class RentPage extends StatelessWidget {
  final Car car;
  final AuthService authService;
  final CommentService commentService;

  const RentPage({
    super.key,
    required this.car,
    required this.authService,
    required this.commentService,
  });

  @override
  Widget build(BuildContext context) {
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
                background: Image.network(
                  car.imageData,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 100);
                  },
                ),
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
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationFormPage(car: car, authService: authService),
                          ),
                        );
                      },
                      child: const Text(
                        'Rent Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsPage(carId: car.id, commentService: commentService),
                          ),
                        );
                      },
                      child: const Text(
                        'Comments',
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