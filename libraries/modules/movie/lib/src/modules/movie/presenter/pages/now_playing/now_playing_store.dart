import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/use_cases/get_movie_now_playing.dart';

class MoviePlayingStore extends StreamStore<Failure, List<Movie>> {
  final IGetMovieNowPlaying _getMovieNowPlaying;
  MoviePlayingStore(this._getMovieNowPlaying) : super([]);

  Future<void> load() => executeEither(() => DartzEitherAdapter.adapter(_getMovieNowPlaying()));
}
