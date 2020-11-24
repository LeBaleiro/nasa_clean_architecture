import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/keys/api_keys.dart';
import '../models/space_media_model.dart';
import 'endpoints/endpoints.dart';

abstract class SpaceMediaDataSource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(String date);

  Future<SpaceMediaModel> getSpaceMediaFromToday();
}

class SpaceMediaDataSourceImpl implements SpaceMediaDataSource {
  final http.Client client;

  SpaceMediaDataSourceImpl(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(String date) async {
    return _getSpaceMediaFromUrl(
        NasaEndpoints.getSpaceMediaFromDate(ApiKeys.apiKey, date));
  }

  @override
  Future<SpaceMediaModel> getSpaceMediaFromToday() {
    return _getSpaceMediaFromUrl(
        NasaEndpoints.getSpaceMediaFromToday(ApiKeys.apiKey));
  }

  Future<SpaceMediaModel> _getSpaceMediaFromUrl(String url) async {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
