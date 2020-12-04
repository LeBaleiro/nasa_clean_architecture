import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'space_images_controller.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  final controller = Modular.get<SpaceImagesController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('APOD'),
          backgroundColor: Colors.blueGrey,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  controller.spaceMedia.title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ExtendedImage.network(
                  controller.spaceMedia.mediaUrl,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 1,
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      controller.spaceMedia.description,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
