import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/core/error/failures.dart';
import 'package:nasa_clean_arch/features/space_images/domain/entities/space_media.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_date.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_today.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/space_images_controller.dart';

class MockGetSpaceMediaFromToday extends Mock
    implements GetSpaceMediaFromToday {}

class MockGetSpaceMediaFromDate extends Mock implements GetSpaceMediaFromDate {}


void main() {
  SpaceImagesController store;
  MockGetSpaceMediaFromDate mockGetSpaceMediaFromDate;
  MockGetSpaceMediaFromToday mockGetSpaceMediaFromToday;


  setUp(() {
    mockGetSpaceMediaFromDate = MockGetSpaceMediaFromDate();
    mockGetSpaceMediaFromToday = MockGetSpaceMediaFromToday();
    store = SpaceImagesController(
      spaceMediaFromDate: mockGetSpaceMediaFromDate,
      spaceMediaFromToday: mockGetSpaceMediaFromToday,
    );
  });

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
    test('should return a SpaceMedia from the usecase', () async {
      when(mockGetSpaceMediaFromDate(any))
          .thenAnswer((_) async => Right(tSpaceMedia));

      await store.getSpaceImageFromDate(tDateTime);

      verify(mockGetSpaceMediaFromDate(tDateTime));
      expect(store.spaceMedia, tSpaceMedia);
    });
    test('should return a Failure from the usecase when there is an error',
        () async {
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
