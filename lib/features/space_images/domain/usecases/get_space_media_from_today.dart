import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/space_media.dart';
import '../repositories/space_media_repository.dart';

class GetSpaceMediaFromToday {
  final SpaceMediaRepository repository;

  GetSpaceMediaFromToday(this.repository);

  Future<Either<Failure, SpaceMedia>> call() async {
    return repository.getSpaceMediaFromToday();
  }
}
