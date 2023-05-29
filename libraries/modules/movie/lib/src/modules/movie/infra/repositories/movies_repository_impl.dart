import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/errors/movie_failures.dart';
import '../data_sources/movie_local_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieDataSource _dataSource;
  final MovieLocalDatasource _localDataSource;
  final ConnectivityClient _connectivity;

  MoviesRepositoryImpl(this._dataSource, this._localDataSource, this._connectivity);

  @override
  Future<Either<Failure, List<Movie>>> getMovieNowPlaying() async {
    if (await _connectivity.checkDataConnection()) {
      try {
        final result = await _dataSource.getMovieNowPlaying();

        if (result.isEmpty) {
          return Left(NoDataFound());
        }

        _localDataSource.setMovieNowPlaying(result);

        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      if (await _connectivity.isWifiConnected()) {
        await _connectivity.switchToMobileData();
        await getMovieNowPlaying();
      }
      final result = await _localDataSource.getMovieNowPlaying();

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviePopular() async {
    if (await _connectivity.checkDataConnection()) {
      try {
        final result = await _dataSource.getMoviePopular();

        if (result.isEmpty) {
          return Left(NoDataFound());
        }

        _localDataSource.setMoviePopular(result);

        return Right(result);
      } on Failure catch (e) {
        return Left(e);
        // ignore: avoid_catches_without_on_clauses
      } catch (exception, stacktrace) {
        return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getMoviePopular'));
      }
    } else {
      await _connectivity.switchToMobileData();
      // if (await _connectivity.isWifiConnected()) {
      //   await _connectivity.switchToMobileData();
      //   await getMoviePopular();
      // }
      final result = await _localDataSource.getMoviePopular();

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieUpComming() async {
    if (await _connectivity.checkDataConnection()) {
      try {
        final result = await _dataSource.getMovieUpComming();

        if (result.isEmpty) {
          return Left(NoDataFound());
        }

        _localDataSource.setMovieUpComming(result);

        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      } on Exception catch (exception, stacktrace) {
        return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getMovieUpComming'));
      }
    } else {
      if (await _connectivity.isWifiConnected()) {
        await _connectivity.switchToMobileData();
        await getMovieUpComming();
      }
      final result = await _localDataSource.getMovieUpComming();

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    }
  }

  @override
  Future<Either<Failure, List<Trailer>>> getMovieTrailerById(int id) async {
    try {
      final result = await _dataSource.getMovieTrailerById(id);

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getMovieTrailerById'));
    }
  }

  @override
  Future<Either<Failure, List<Trailer>>> getTvShowTrailerById(int id) async {
    try {
      final result = await _dataSource.getTvShowTrailerById(id);

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getTvShowTrailer'));
    }
  }

  @override
  Future<Either<Failure, List<Crew>>> getMovieCrewById(int id) async {
    try {
      final result = await _dataSource.getMovieCrewById(id);

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getTvShowTrailer'));
    }
  }

  @override
  Future<Either<Failure, List<Crew>>> getTvShowCrewById(int id) async {
    try {
      final result = await _dataSource.getTvShowCrewById(id);

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getTvShowTrailer'));
    }
  }
}
