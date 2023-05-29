import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie/src/modules/movie/domain/use_cases/get_movie_up_coming.dart';

import '../../../domain/entities/movie.dart';

class UpComingWidgetStore extends StreamStore<Failure, List<Movie>> {
  final IGetMovieUpComming _getMovieUpComming;

  UpComingWidgetStore(this._getMovieUpComming) : super([]);

  Future<void> load() => executeEither(() => DartzEitherAdapter.adapter(_getMovieUpComming()));
}
