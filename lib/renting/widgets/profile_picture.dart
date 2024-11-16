import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/renting/screens/editProfile_page.dart';


class ProfilePicture extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClick;

  const ProfilePicture({
    super.key,
    required this.imagePath,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    const color = Colors.orangeAccent;

    return Center(
        child: Stack(
          children: [
            buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(context, color),
            )
          ],
        )
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(onTap: onClick),
            )
        )
    );
  }

  Widget buildEditIcon(BuildContext context, Color color) => buildCircle(
      color: Colors.white,
      all: 2,
      child: buildCircle(
          color: color,
          all: 4,
          child: IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          )
      )
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}