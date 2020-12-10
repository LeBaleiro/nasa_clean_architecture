import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/widgets/custom_app_bar.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/widgets/custom_shimmer.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/widgets/description_bottom_sheet.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/widgets/image_network_with_loader.dart';

import 'space_images_controller.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  final moduleController = Modular.get<SpaceImagesController>();
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (moduleController.spaceMedia?.mediaType == 'video') {
      _videoController =
          VideoPlayerController.network(moduleController.spaceMedia?.mediaUrl)
            ..initialize().then((_) {
              setState(() {});
              _videoController.play();
              _videoController.setVolume(0);
              _videoController.setLooping(true);
            });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (moduleController.spaceMedia?.mediaType == 'video') {
      _videoController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(title: 'APOD'),
          body: GestureDetector(
              onVerticalDragUpdate: (update) {
                if (update.delta.dy < 0) {
                  showDescriptionBottomSheet(
                    context: context,
                    title: moduleController.spaceMedia?.title,
                    description: moduleController.spaceMedia?.description,
                  );
                }
              },
              child: moduleController.error == null
                  ? Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: moduleController.spaceMedia?.mediaType ==
                                  'video'
                              ? _videoController.value.initialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _videoController.value.aspectRatio,
                                      child: VideoPlayer(_videoController),
                                    )
                                  : Container()
                              : ImageNetworkWithLoader(
                                  moduleController.spaceMedia?.mediaUrl,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                            child: CustomShimmer(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 35,
                                  ),
                                  Text(
                                    "Slide up to see the description",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'An error occurred, try again later.',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )),
        );
      },
    );
//    });
  }
}
