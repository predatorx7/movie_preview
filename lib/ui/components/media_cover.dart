import 'package:flutter/material.dart';
import 'package:movie_preview/models/plain/media.dart';

class MediaCover extends StatelessWidget {
  final double width;
  final Shows media;

  /// Displays a poster of the [Shows]
  const MediaCover({
    Key? key,
    required this.width,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            image: NetworkImage(media.poster ?? ''),
          ),
        ),
      ),
    );
  }
}
