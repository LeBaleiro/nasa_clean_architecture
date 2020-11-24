import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/space_media.dart';

class SpaceMediaModel extends SpaceMedia {
  SpaceMediaModel({
    @required String datePublished,
    @required String description,
    @required String mediaType,
    @required String title,
    @required String mediaUrl,
  }) : super(
          datePublished: datePublished,
          description: description,
          mediaType: mediaType,
          title: title,
          mediaUrl: mediaUrl,
        );
  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) {
    return SpaceMediaModel(
        datePublished: json['date'],
        description: json['explanation'],
        mediaType: json['media_type'],
        title: json['title'],
        mediaUrl: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'date': datePublished,
      'explanation': description,
      'media_type': mediaType,
      'title': title,
      'url': mediaUrl,
    };
  }
}
