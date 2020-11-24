import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/features/space_images/domain/entities/space_media.dart';
import 'package:nasa_clean_arch/features/space_images/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_date.dart';

class MockSpaceMediaRepository extends Mock implements SpaceMediaRepository {}

void main() {
  GetSpaceMediaFromDate usecase;
  MockSpaceMediaRepository mockSpaceMediaRepository;

  setUp(() {
    mockSpaceMediaRepository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDate(mockSpaceMediaRepository);
  });

  final tSpaceMedia = SpaceMedia(
    datePublished: "2020-11-19",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );

  final tDate = "2020-10-22";

  test('should get space media for a given date from the repository', () async {
    when(mockSpaceMediaRepository.getSpaceMediaFromDate(any))
        .thenAnswer((_) async => Right(tSpaceMedia));
    final result = await usecase(tDate);
    expect(result, Right(tSpaceMedia));
    verify(mockSpaceMediaRepository.getSpaceMediaFromDate(tDate));
    verifyNoMoreInteractions(mockSpaceMediaRepository);
  });
}
