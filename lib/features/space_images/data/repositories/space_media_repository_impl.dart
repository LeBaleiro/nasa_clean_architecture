import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/space_media.dart';
import '../../domain/repositories/space_media_repository.dart';
import '../datasources/space_media_data_source.dart';

typedef Future<SpaceMedia> _GetSpaceMediaFromTodayOrFromDate();

class SpaceMediaRepositoryImpl implements SpaceMediaRepository {
  final SpaceMediaDataSource dataSource;

  SpaceMediaRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, SpaceMedia>> getSpaceMediaFromToday() async {
    return await _getSpaceMedia(() {
      return dataSource.getSpaceMediaFromToday();
    });
  }

  @override
  Future<Either<Failure, SpaceMedia>> getSpaceMediaFromDate(String date) async {
    return await _getSpaceMedia(() {
      return dataSource.getSpaceMediaFromDate(date);
    });
  }

  Future<Either<Failure, SpaceMedia>> _getSpaceMedia(
      _GetSpaceMediaFromTodayOrFromDate
          getSpaceMediaFromTodayOrFromDate) async {
    try {
      final result = await getSpaceMediaFromTodayOrFromDate();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
