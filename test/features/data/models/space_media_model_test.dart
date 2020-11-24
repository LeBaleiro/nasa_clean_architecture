import 'dart:convert';
import 'package:nasa_clean_arch/mock_response/space_media_mock.dart';
import 'package:test/test.dart';
import 'package:nasa_clean_arch/features/space_images/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/space_images/domain/entities/space_media.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    datePublished: "2020-10-22",
    description: "test description",
    mediaType: "image",
    title: "test title",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg",
  );

  test('should be a subclass of SpaceMedia entity', () {
    expect(tSpaceMediaModel, isA<SpaceMedia>());
  });

  test('should return a valid model', () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    final result = SpaceMediaModel.fromJson(jsonMap);
    expect(result, tSpaceMediaModel);
  });

  test('should return a json map containing the proper data', () {
    final result = tSpaceMediaModel.toJson();
    final expectedMap = {
      "date": "2020-10-22",
      "explanation": "test description",
      "media_type": "image",
      "title": "test title",
      "url":
          "https://apod.nasa.gov/apod/image/2011/spacex-crew-1-JenScottPhotography-11_1050.jpg"
    };
    expect(result, expectedMap);
  });
}
