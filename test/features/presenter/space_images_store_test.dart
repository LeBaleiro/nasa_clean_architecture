import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/core/error/failures.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/space_images/domain/entities/space_media.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_date.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_today.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/space_images_store.dart';

class MockGetSpaceMediaFromToday extends Mock
    implements GetSpaceMediaFromToday {}

class MockGetSpaceMediaFromDate extends Mock implements GetSpaceMediaFromDate {}

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

  final tSpaceMedia = SpaceMedia(
    datePublished: "2020-11-01",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );
  group('getSpaceMediaFromDate', () {
    test(
        'should call DateInputConverter to convert the data into a formatted string',
        () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      when(mockGetSpaceMediaFromDate(any))
          .thenAnswer((_) async => Right(tSpaceMedia));

      await store.getSpaceImageFromDate(tDateTime);

      verify(mockDateInputConverter.format(tDateTime));
    });
    test('should return a SpaceMedia from the usecase', () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      when(mockGetSpaceMediaFromDate(any))
          .thenAnswer((_) async => Right(tSpaceMedia));

      await store.getSpaceImageFromDate(tDateTime);

      verify(mockGetSpaceMediaFromDate(tDateTimeString));
      expect(store.spaceMedia, tSpaceMedia);
    });
    test('should return a Failure from the usecase when there is an error',
        () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      when(mockGetSpaceMediaFromDate(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      await store.getSpaceImageFromDate(tDateTime);

      expect(store.error, ServerFailure());
    });
  });
  group('getSpaceMediaFromToday', () {
    test(
        'should store into a variable the SpaceMedia returned from the usecase',
        () async {
      when(mockGetSpaceMediaFromToday())
          .thenAnswer((_) async => Right(tSpaceMedia));

      await store.getSpaceImageFromToday();

      verify(mockGetSpaceMediaFromToday());
      expect(store.spaceMedia, tSpaceMedia);
    });
    test('should return a Failure from the usecase when there is an error',
        () async {
      when(mockGetSpaceMediaFromToday())
          .thenAnswer((_) async => Left(ServerFailure()));

      await store.getSpaceImageFromToday();

      expect(store.error, ServerFailure());
    });
  });
}
