import 'package:flutter/material.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/ui/components/media_cover.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Media media = Provider.of<Media>(context);
    const double scale = 1;
    const double height = 200 * scale;
    const double width = 120 * scale;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(media.title ?? ''),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: height,
              child: MediaCover(
                media: media,
                width: width,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
