import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:nasa_clean_arch/core/error/exceptions.dart';
import 'package:nasa_clean_arch/core/keys/api_keys.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/space_images/data/datasources/space_media_data_source.dart';
import 'package:nasa_clean_arch/features/space_images/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/mock_response/space_media_mock.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockDateInputConverter extends Mock implements DateInputConverter {}

void main() {
  SpaceMediaDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  MockDateInputConverter mockDateInputConverter;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockDateInputConverter = MockDateInputConverter();
    dataSource = SpaceMediaDataSourceImpl(
      client: mockHttpClient,
      dateInputConverter: mockDateInputConverter,
    );
  });

  final tDateTime = DateTime(2020, 11, 01);

  final tDateTimeString = '2020-11-01';

  final tSpaceMediaModel = SpaceMediaModel(
    datePublished: "2020-10-22",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );

  void sucessHttpMock() {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response(spaceMediaMock, 200),
    );
  }

  void failureHttpMock() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getSpaceMediaFromDate', () {
    test(
        'should call DateInputConverter to convert the data into a formatted string',
        () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      sucessHttpMock();

      await dataSource.getSpaceMediaFromDate(tDateTime);

      verify(mockDateInputConverter.format(tDateTime));
    });
    test('should call the get method with correct url', () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      sucessHttpMock();
      await dataSource.getSpaceMediaFromDate(tDateTime);
      verify(mockHttpClient.get(
          "https://api.nasa.gov/planetary/apod?hd=true&api_key=${ApiKeys.apiKey}&date=$tDateTimeString"));
    });
    test('should return SpaceMedia when the response code is 200 (success)',
        () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      sucessHttpMock();
      final result = await dataSource.getSpaceMediaFromDate(tDateTime);
      expect(result, equals(tSpaceMediaModel));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockDateInputConverter.format(any)).thenReturn(tDateTimeString);
      failureHttpMock();
      final result = dataSource.getSpaceMediaFromDate(tDateTime);
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getSpaceMediaFromToday', () {
    test('should call the get method with correct url', () async {
      sucessHttpMock();
      await dataSource.getSpaceMediaFromToday();
      verify(mockHttpClient.get(
          "https://api.nasa.gov/planetary/apod?hd=true&api_key=${ApiKeys.apiKey}"));
    });
    test('should return SpaceMedia when the response code is 200 (success)',
        () async {
      sucessHttpMock();
      final result = await dataSource.getSpaceMediaFromToday();
      expect(result, equals(tSpaceMediaModel));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      failureHttpMock();
      final result = dataSource.getSpaceMediaFromToday();
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });
}
