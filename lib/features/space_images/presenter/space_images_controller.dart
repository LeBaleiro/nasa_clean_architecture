import 'package:mobx/mobx.dart';
import 'package:nasa_clean_arch/core/error/failures.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/space_images/domain/entities/space_media.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_date.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_today.dart';
part 'space_images_controller.g.dart';

class SpaceImagesController = _SpaceImagesControllerBase
    with _$SpaceImagesController;

abstract class _SpaceImagesControllerBase with Store {
  final GetSpaceMediaFromDate spaceMediaFromDate;
  final GetSpaceMediaFromToday spaceMediaFromToday;
  final DateInputConverter dateInputConverter;

  _SpaceImagesControllerBase({
    this.spaceMediaFromDate,
    this.spaceMediaFromToday,
    this.dateInputConverter,
  });

  @observable
  SpaceMedia spaceMedia;

  @observable
  Failure error;

  @action
  Future<void> getSpaceImageFromDate(DateTime date) async {
    final dateIntoString = dateInputConverter.format(date);
    final result = await spaceMediaFromDate(dateIntoString);
    result.fold((l) => error = l, (r) => spaceMedia = r);
  }

  @action
  Future<void> getSpaceImageFromToday() async {
    final result = await spaceMediaFromToday();
    result.fold((l) => error = l, (r) => spaceMedia = r);
  }
}
