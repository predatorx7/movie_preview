import 'package:flutter/material.dart';
import 'package:movie_preview/commons/assets.dart';

const user = 'Chelsie Brett';

class AppbarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: MyAssets.avatarImage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(user, style: Theme.of(context).textTheme.subtitle2),
        ),
      ],
    );
  }
}
