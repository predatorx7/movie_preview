import 'package:flutter/material.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/ui/components/media_cover.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Media media = Provider.of<Media>(context);
    final double scale = 1;
    final double height = 200 * scale;
    final double width = 120 * scale;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(media.title),
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: height,
              child: MediaCover(
                media: media,
                width: width,
              ),
            ),
            Expanded(
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
