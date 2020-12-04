import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'space_images_controller.dart';
import 'widgets/round_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SpaceImagesController>();
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('APOD'),
          backgroundColor: Colors.blueGrey,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Welcome to Astronomy Picture of the Day!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                  ),
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
    });
  }
}
