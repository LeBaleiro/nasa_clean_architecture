import 'package:nasa_clean_arch/core/keys/api_keys.dart';
import 'package:nasa_clean_arch/mock_response/space_media_mock.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/core/error/exceptions.dart';
import 'package:nasa_clean_arch/features/space_images/data/datasources/space_media_data_source.dart';
import 'package:nasa_clean_arch/features/space_images/data/models/space_media_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  SpaceMediaDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SpaceMediaDataSourceImpl(mockHttpClient);
  });

  final tDate = "2020 - 10 - 22";
  final tSpaceMediaModel = SpaceMediaModel(
    datePublished: "2020-10-22",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );

  void sucessMock() {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response(spaceMediaMock, 200),
    );
  }

  void failureMock() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getSpaceMediaFromDate', () {
    test('should call the get method with correct url', () async {
      sucessMock();
      dataSource.getSpaceMediaFromDate(tDate);
      verify(mockHttpClient.get(
          "https://api.nasa.gov/planetary/apod?api_key=${ApiKeys.apiKey}&date=$tDate"));
    });
    test('should return SpaceMedia when the response code is 200 (success)',
        () async {
      sucessMock();
      final result = await dataSource.getSpaceMediaFromDate(tDate);
      expect(result, equals(tSpaceMediaModel));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      failureMock();
      final result = dataSource.getSpaceMediaFromDate(tDate);
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getSpaceMediaFromToday', () {
    test('should call the get method with correct url', () async {
      sucessMock();
      dataSource.getSpaceMediaFromToday();
      verify(mockHttpClient.get(
          "https://api.nasa.gov/planetary/apod?api_key=${ApiKeys.apiKey}"));
    });
    test('should return SpaceMedia when the response code is 200 (success)',
        () async {
      sucessMock();
      final result = await dataSource.getSpaceMediaFromToday();
      expect(result, equals(tSpaceMediaModel));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      failureMock();
      final result = dataSource.getSpaceMediaFromToday();
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });
}
