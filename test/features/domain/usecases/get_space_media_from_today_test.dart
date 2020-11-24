import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/features/space_images/domain/entities/space_media.dart';
import 'package:nasa_clean_arch/features/space_images/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_today.dart';

class MockSpaceMediaRepository extends Mock implements SpaceMediaRepository {}

void main() {
  GetSpaceMediaFromToday usecase;
  MockSpaceMediaRepository mockSpaceMediaRepository;

  setUp(() {
    mockSpaceMediaRepository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromToday(mockSpaceMediaRepository);
  });

  final tSpaceMedia = SpaceMedia(
    datePublished: "2020-11-19",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );

  test('should get space media for today from the repository', () async {
    when(mockSpaceMediaRepository.getSpaceMediaFromToday())
        .thenAnswer((_) async => Right(tSpaceMedia));
    final result = await usecase();
    expect(result, Right(tSpaceMedia));
    verify(mockSpaceMediaRepository.getSpaceMediaFromToday());
    verifyNoMoreInteractions(mockSpaceMediaRepository);
  });
}
