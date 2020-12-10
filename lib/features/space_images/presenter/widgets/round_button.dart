import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final Color buttonColor;
  final Color textColor;

  RoundButton({
    this.label,
    this.onTap,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: buttonColor,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
