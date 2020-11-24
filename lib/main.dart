import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
            child: Center(child: Text("aaaa")),
            onTap: () async {
              var datePicked = await showDatePicker(
                helpText: "Escolha uma data",
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1995, 06, 16),
                lastDate: DateTime.now(),
              );
            }),
      ),
    );
  }
}
