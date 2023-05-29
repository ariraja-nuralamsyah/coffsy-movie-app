import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import 'movie_data_source.dart';

abstract class MovieLocalDatasource extends MovieDataSource {
  void setMovieNowPlaying(List<Movie> data);
  void setMoviePopular(List<Movie> data);
  void setMovieUpComming(List<Movie> data);
  void setMovieTrailerById(List<Trailer> data, int id);
  void setTvShowTrailerById(List<Trailer> data, int id);

  void setMovieCrewById(List<Crew> data, int id);

  void setTvShowCrewById(List<Crew> data, int id);
}
