import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../infra/data_sources/movie_local_data_source.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';

class MovieLocalDataSourceImpl extends MovieLocalDatasource {
  final SharedPrefHelper shared;

  MovieLocalDataSourceImpl(this.shared);

  @override
  Future<List<Movie>> getMovieNowPlaying() async {
    final movie = shared.getCacheList('getMovieNowPlaying');
    if (movie.isNotEmpty) {
      return movie.map((e) => MovieMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Movie>> getMoviePopular() async {
    final movie = shared.getCacheList('getMoviePopular');
    if (movie.isNotEmpty) {
      return movie.map((e) => MovieMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Movie>> getMovieUpComming() async {
    final movie = shared.getCacheList('getMovieUpComming');
    if (movie.isNotEmpty) {
      return movie.map((e) => MovieMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int id) async {
    final movie = shared.getCacheList('getMovieTrailerById:$id');
    if (movie.isNotEmpty) {
      return movie.map((e) => TrailerMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int id) async {
    final movie = shared.getCacheList('getTvShowTrailerById:$id');
    if (movie.isNotEmpty) {
      return movie.map((e) => TrailerMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Crew>> getMovieCrewById(int id) async {
    final movie = shared.getCacheList('getMovieCrewById:$id');
    if (movie.isNotEmpty) {
      return movie.map((e) => CrewMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int id) async {
    final movie = shared.getCacheList('getTvShowCrewById:$id');
    if (movie.isNotEmpty) {
      return movie.map((e) => CrewMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  void setMovieNowPlaying(List<Movie> data) {
    shared.storeCacheList('getMovieNowPlaying', data.map((e) => json.encode(MovieMapper.toMap(e))).toList());
  }

  @override
  void setMoviePopular(List<Movie> data) {
    shared.storeCacheList('getMoviePopular', data.map((e) => json.encode(MovieMapper.toMap(e))).toList());
  }

  @override
  void setMovieUpComming(List<Movie> data) {
    shared.storeCacheList('getMovieUpComming', data.map((e) => json.encode(MovieMapper.toMap(e))).toList());
  }

  @override
  void setMovieTrailerById(List<Trailer> data, int id) {
    shared.storeCacheList('getMovieTrailerById:$id', data.map((e) => json.encode(TrailerMapper.toMap(e))).toList());
  }

  @override
  void setTvShowTrailerById(List<Trailer> data, int id) {
    shared.storeCacheList('getTvShowTrailerById:$id', data.map((e) => json.encode(TrailerMapper.toMap(e))).toList());
  }

  @override
  void setMovieCrewById(List<Crew> data, int id) {
    shared.storeCacheList('getMovieCrewById:$id', data.map((e) => json.encode(CrewMapper.toMap(e))).toList());
  }

  @override
  void setTvShowCrewById(List<Crew> data, int id) {
    shared.storeCacheList('getTvShowCrewById:$id', data.map((e) => json.encode(CrewMapper.toMap(e))).toList());
  }
}
