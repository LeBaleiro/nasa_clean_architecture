import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/core/error/exceptions.dart';
import 'package:nasa_clean_arch/core/error/failures.dart';
import 'package:nasa_clean_arch/features/space_images/data/datasources/space_media_data_source.dart';
import 'package:nasa_clean_arch/features/space_images/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/space_images/data/repositories/space_media_repository_impl.dart';

class MockSpaceMediaDataSource extends Mock implements SpaceMediaDataSource {}

void main() {
  MockSpaceMediaDataSource mockSpaceMediaDataSource;
  SpaceMediaRepositoryImpl repository;

  setUp(() {
    mockSpaceMediaDataSource = MockSpaceMediaDataSource();
    repository = SpaceMediaRepositoryImpl(mockSpaceMediaDataSource);
  });
  final tSpaceMediaModel = SpaceMediaModel(
    datePublished: "2020-11-01",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );

  group('getSpaceMediaFromToday', () {
    test(
        'should return remote data when the call to remote data source is sucessful',
        () async {
      when(mockSpaceMediaDataSource.getSpaceMediaFromToday())
          .thenAnswer((_) async => tSpaceMediaModel);

      final result = await repository.getSpaceMediaFromToday();

      verify(mockSpaceMediaDataSource.getSpaceMediaFromToday());
      expect(result, equals(Right(tSpaceMediaModel)));
    });

    test(
        'should return server failure when the call to remote data is unsucessful',
        () async {
      when(mockSpaceMediaDataSource.getSpaceMediaFromToday())
          .thenThrow(ServerException());

      final result = await repository.getSpaceMediaFromToday();

      verify(mockSpaceMediaDataSource.getSpaceMediaFromToday());
      expect(result, equals(Left(ServerFailure())));
    });
  });
  group('getSpaceMediaFromDate', () {
    final tDateTime = DateTime(2020, 11, 01);
    test(
        'should return remote data when the call to remote data source is sucessful',
        () async {
      when(mockSpaceMediaDataSource.getSpaceMediaFromDate(tDateTime))
          .thenAnswer((_) async => tSpaceMediaModel);

      final result = await repository.getSpaceMediaFromDate(tDateTime);

      verify(mockSpaceMediaDataSource.getSpaceMediaFromDate(tDateTime));
      expect(result, equals(Right(tSpaceMediaModel)));
    });

    test(
        'should return server failure when the call to remote data is unsucessful',
        () async {
      when(mockSpaceMediaDataSource.getSpaceMediaFromDate(tDateTime))
          .thenThrow(ServerException());

      final result = await repository.getSpaceMediaFromDate(tDateTime);

      verify(mockSpaceMediaDataSource.getSpaceMediaFromDate(tDateTime));
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
