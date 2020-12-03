import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_arch/app_widget.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/space_images/data/datasources/space_media_data_source.dart';
import 'package:nasa_clean_arch/features/space_images/data/repositories/space_media_repository_impl.dart';
import 'package:nasa_clean_arch/features/space_images/domain/usecases/get_space_media_from_today.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/home_page.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/picture_page.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/space_images_controller.dart';

import 'features/space_images/domain/usecases/get_space_media_from_date.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SpaceImagesController(
              spaceMediaFromDate: i(),
              spaceMediaFromToday: i(),
              dateInputConverter: i(),
            )),
        Bind((i) => GetSpaceMediaFromDate(i())),
        Bind((i) => GetSpaceMediaFromToday(i())),
        Bind((i) => SpaceMediaRepositoryImpl(i())),
        Bind((i) => SpaceMediaDataSourceImpl(i())),
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
