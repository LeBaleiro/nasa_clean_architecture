import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/keys/api_keys.dart';
import '../../../../core/utils/date_input_converter.dart';
import '../models/space_media_model.dart';
import 'endpoints/endpoints.dart';

abstract class SpaceMediaDataSource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);

  Future<SpaceMediaModel> getSpaceMediaFromToday();
}

class SpaceMediaDataSourceImpl implements SpaceMediaDataSource {
  final http.Client client;
  final DateInputConverter dateInputConverter;

  SpaceMediaDataSourceImpl({
    @required this.client,
    @required this.dateInputConverter,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = dateInputConverter.format(date);
    return _getSpaceMediaFromUrl(
        NasaEndpoints.getSpaceMediaFromDate(ApiKeys.apiKey, dateConverted));
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
