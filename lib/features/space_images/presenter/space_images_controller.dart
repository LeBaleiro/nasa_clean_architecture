import 'package:mobx/mobx.dart';

import '../../../core/error/failures.dart';
import '../domain/entities/space_media.dart';
import '../domain/usecases/get_space_media_from_date.dart';
import '../domain/usecases/get_space_media_from_today.dart';

part 'space_images_controller.g.dart';

class SpaceImagesController = _SpaceImagesControllerBase
    with _$SpaceImagesController;

abstract class _SpaceImagesControllerBase with Store {
  final GetSpaceMediaFromDate spaceMediaFromDate;
  final GetSpaceMediaFromToday spaceMediaFromToday;

  _SpaceImagesControllerBase({
    this.spaceMediaFromDate,
    this.spaceMediaFromToday,
  });

  @observable
  SpaceMedia spaceMedia;

  @observable
  Failure error;

  @action
  Future<void> getSpaceImageFromDate(DateTime date) async {
    final result = await spaceMediaFromDate(date);
    result.fold((l) => error = l, (r) => spaceMedia = r);
  }

  @action
  Future<void> getSpaceImageFromToday() async {
    final result = await spaceMediaFromToday();
    result.fold((l) => error = l, (r) => spaceMedia = r);
  }
}
