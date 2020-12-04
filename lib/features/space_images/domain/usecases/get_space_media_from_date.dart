import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/space_media.dart';
import '../repositories/space_media_repository.dart';

class GetSpaceMediaFromDate {
  final SpaceMediaRepository repository;

  GetSpaceMediaFromDate(this.repository);
  Future<Either<Failure, SpaceMedia>> call(DateTime date) async {
    return repository.getSpaceMediaFromDate(date);
  }
}