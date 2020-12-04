import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/space_media.dart';

abstract class SpaceMediaRepository {
  Future<Either<Failure, SpaceMedia>> getSpaceMediaFromToday();
  Future<Either<Failure, SpaceMedia>> getSpaceMediaFromDate(DateTime date);
}