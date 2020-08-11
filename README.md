# movie_preview

A flutter project to show movie details with flutter API integration

## Preview

<img src='https://github.com/predatorx7/movie_preview/blob/master/result_preview/preview_1.png'  width="400">

## Working

MaterialApp uses routes generated from [generateRoute method](https://github.com/predatorx7/movie_preview/blob/15ce35b88c96eb45ea6835ed00305246b7b3b3c1/lib/commons/routes.dart#L23) and themes from [themeData in lib/commons/styles.dart](https://github.com/predatorx7/movie_preview/blob/15ce35b88c96eb45ea6835ed00305246b7b3b3c1/lib/commons/styles.dart#L3)

[Media](https://github.com/predatorx7/movie_preview/blob/15ce35b88c96eb45ea6835ed00305246b7b3b3c1/lib/models/plain/media.dart#L10) is the plain model class for json data recieved from the API. The raw json response is parsed by the [MediaRepository](https://github.com/predatorx7/movie_preview/blob/master/lib/models/repository/media.dart) which stores list of [Media](https://github.com/predatorx7/movie_preview/blob/15ce35b88c96eb45ea6835ed00305246b7b3b3c1/lib/models/plain/media.dart#L10)

Application uses stream controller from [MediaRepository](https://github.com/predatorx7/movie_preview/blob/master/lib/models/repository/media.dart) to update & make api calls using the [MediaAPIClient](https://github.com/predatorx7/movie_preview/blob/master/lib/api/client.dart).
