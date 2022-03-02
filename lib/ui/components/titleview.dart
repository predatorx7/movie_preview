import 'package:flutter/material.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/models/provider/shows.dart';
import 'package:movie_preview/ui/components/media_cover.dart';
import 'package:movie_preview/ui/screens/movie_details.dart';
import 'package:provider/provider.dart';

class MediasView extends StatelessWidget {
  final List<Shows> data;
  final String label;
  final double size;
  final bool showLabel;

  const MediasView(
    this.label,
    this.data, {
    Key? key,
    this.size = 13,
    this.showLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    final double _mediaHeight = 16 * size;
    final double _mediaWidth = 9 * size;
    final _label = label.toUpperCase();
    final textStyle = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 16, 0, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              _label,
              style: textStyle,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: _mediaHeight),
            child: ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Shows media = data[index];
                Widget child = MediaCover(
                  width: _mediaWidth,
                  media: media,
                );
                if (showLabel) {
                  child = Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      child,
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.green,
                        ),
                        child: Text(
                          _label,
                          style: textStyle?.merge(
                            const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Provider<Shows>.value(
                          value: media,
                          child: const MovieDetails(),
                        ),
                      ),
                    );
                  },
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowsProvider>(
      builder: (context, value, child) {
        final List<Shows>? data = value.data;
        if (data == null) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        return Expanded(
          child: ListView(
            children: [
              MediasView('New', data, showLabel: true),
              MediasView('Popular', data),
              MediasView('Trending', data),
            ],
          ),
        );
      },
    );
  }
}
