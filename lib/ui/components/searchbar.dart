import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _leftBorderRadius = Radius.circular(4);
    final _searchTextTheme =
        Theme.of(context).textTheme.button.apply(color: Colors.grey);
    return Center(
      child: Material(
        borderRadius: BorderRadius.only(
            topLeft: _leftBorderRadius, bottomLeft: _leftBorderRadius),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                EvaIcons.search,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Search',
                style: _searchTextTheme,
              ),
            )
          ],
        ),
        shadowColor: Colors.transparent,
      ),
    );
  }
}
