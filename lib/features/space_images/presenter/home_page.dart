import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/space_images_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SpaceImagesController>();
    DateTime datePicked;
    return Observer(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                  child: Center(child: Text("Selecionar data")),
                  onTap: () async {
                    datePicked = await showDatePicker(
                      helpText: "Escolha uma data",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1995, 06, 16),
                      lastDate: DateTime.now(),
                    );
                  }),
              GestureDetector(
                  child: Center(child: Text("Buscar")),
                  onTap: () async {
                    await controller.getSpaceImageFromDate(datePicked);
                    print(controller.spaceMedia.title);
                    Modular.to.pushNamed('/picture');
                  }),
            ],
          ),
        ),
      );
    });
  }
}
