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
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: MyAssets.avatarImage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(user, style: Theme.of(context).textTheme.bodyText2),
        ),
      ],
    );
  }
}
