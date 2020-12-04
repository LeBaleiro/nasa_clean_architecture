import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'app_widget.dart';
import 'core/utils/date_input_converter.dart';
import 'features/space_images/data/datasources/space_media_data_source.dart';
import 'features/space_images/data/repositories/space_media_repository_impl.dart';
import 'features/space_images/domain/usecases/get_space_media_from_date.dart';
import 'features/space_images/domain/usecases/get_space_media_from_today.dart';
import 'features/space_images/presenter/home_page.dart';
import 'features/space_images/presenter/picture_page.dart';
import 'features/space_images/presenter/space_images_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SpaceImagesController(
              spaceMediaFromDate: i(),
              spaceMediaFromToday: i(),
            )),
        Bind((i) => GetSpaceMediaFromDate(i())),
        Bind((i) => GetSpaceMediaFromToday(i())),
        Bind((i) => SpaceMediaRepositoryImpl(i())),
        Bind((i) => SpaceMediaDataSourceImpl(
              client: i(),
              dateInputConverter: i(),
            )),
        Bind((i) => http.Client()),
        Bind((i) => DateInputConverter()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => HomePage()),
        ModularRouter('/picture', child: (_, __) => PicturePage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
