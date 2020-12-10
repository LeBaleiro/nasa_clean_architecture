import 'package:flutter/material.dart';

void showDescriptionBottomSheet({
  @required BuildContext context,
  @required String title,
  @required String description,
}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF3E4C5C).withOpacity(0.9),
      builder: (_) {
        return ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ]);
      });
}
