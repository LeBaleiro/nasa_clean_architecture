import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/features/space_images/presenter/widgets/custom_app_bar.dart';

import 'space_images_controller.dart';
import 'widgets/round_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SpaceImagesController>();
    return Scaffold(
      appBar: CustomAppBar(title: 'APOD'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Welcome to Astronomy Picture of the Day!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 150,
              ),
              RoundButton(
                label: "Select datetime",
                onTap: () async {
                  var datePicked = await showDatePicker(
                    helpText: "Select a datetime",
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1995, 06, 16),
                    lastDate: DateTime.now(),
                  );
                  await controller.getSpaceImageFromDate(datePicked);
                  Modular.to.pushNamed('/picture');
                },
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  label: "See today's image",
                  onTap: () async {
                    await controller.getSpaceImageFromToday();
                    Modular.to.pushNamed('/picture');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
