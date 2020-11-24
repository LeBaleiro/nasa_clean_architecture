import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SpaceMedia extends Equatable {
  final String datePublished;
  final String description;
  final String mediaType;
  final String title;
  final String mediaUrl;

  SpaceMedia({
    @required this.datePublished,
    @required this.description,
    @required this.mediaType,
    @required this.title,
    @required this.mediaUrl,
  });

  @override
  List<Object> get props {
    return [
      datePublished,
      description,
      mediaType,
      title,
      mediaUrl,
    ];
  }
}
