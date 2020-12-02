// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_images_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SpaceImagesStore on _SpaceImagesStoreBase, Store {
  final _$spaceMediaAtom = Atom(name: '_SpaceImagesStoreBase.spaceMedia');

  @override
  SpaceMedia get spaceMedia {
    _$spaceMediaAtom.reportRead();
    return super.spaceMedia;
  }

  @override
  set spaceMedia(SpaceMedia value) {
    _$spaceMediaAtom.reportWrite(value, super.spaceMedia, () {
      super.spaceMedia = value;
    });
  }

  final _$errorAtom = Atom(name: '_SpaceImagesStoreBase.error');

  @override
  Failure get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Failure value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$getSpaceImageFromDateAsyncAction =
      AsyncAction('_SpaceImagesStoreBase.getSpaceImageFromDate');

  @override
  Future<void> getSpaceImageFromDate(DateTime date) {
    return _$getSpaceImageFromDateAsyncAction
        .run(() => super.getSpaceImageFromDate(date));
  }

  @override
  String toString() {
    return '''
spaceMedia: ${spaceMedia},
error: ${error}
    ''';
  }
}
