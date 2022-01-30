import 'package:flash_chat/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final double size;
  const ProfilePicture({
    Key? key,
    required this.size,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Themes.primaryColor,
        radius: size,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imagePath),
          radius: size,
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: GestureDetector(
      //     onTap: () {},
      //     child: Text(
      //       "Change profile picture",
      //       style: Theme.of(context).textTheme.bodyText2,
      //     ),
      //   ),
      // ),
    );
  }
}

//
