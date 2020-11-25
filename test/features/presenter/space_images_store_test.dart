import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_date.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_today.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/space_images_store.dart';

class MockGetSpaceMediaFromDate extends Mock implements GetSpaceMediaFromDate {}

class MockGetSpaceMediaFromToday extends Mock
    implements GetSpaceMediaFromToday {}

class MockDateInputConverter extends Mock implements DateInputConverter {}

void main() {
  SpaceImagesStore store;
  MockGetSpaceMediaFromDate mockGetSpaceMediaFromDate;
  MockGetSpaceMediaFromToday mockGetSpaceMediaFromToday;
  MockDateInputConverter mockDateInputConverter;

  setUp(() {
    mockGetSpaceMediaFromDate = MockGetSpaceMediaFromDate();
    mockGetSpaceMediaFromToday = MockGetSpaceMediaFromToday();
    mockDateInputConverter = MockDateInputConverter();
    store = SpaceImagesStore(
      spaceMediaFromDate: mockGetSpaceMediaFromDate,
      spaceMediaFromToday: mockGetSpaceMediaFromToday,
      dateInputConverter: mockDateInputConverter,
    );
  });

  final tDateTimeString = '2020-11-01';

  final tDateTime = DateTime(2020, 11, 01);

  test(
      'should call DateInputConverter to convert the data into a formatted string',
      () {
    when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);

    store.getSpaceImageFromDate(tDateTime);

    verify(mockDateInputConverter.format(tDateTime));
  });
}
