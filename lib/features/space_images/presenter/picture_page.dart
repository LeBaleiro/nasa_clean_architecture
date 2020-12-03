import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/space_images_controller.dart';

class PicturePage extends StatelessWidget {
  final controller = Modular.get<SpaceImagesController>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Text(controller.spaceMedia.title),
          Image.network(controller.spaceMedia.mediaUrl),
          Text(controller.spaceMedia.description),
        ],
      );
    });
  }
}
