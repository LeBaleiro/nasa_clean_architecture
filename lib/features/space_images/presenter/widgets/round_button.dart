import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String label;
  final Function onTap;

  RoundButton({
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: Color(0xFFF4F2F1),
        ),
        height: 42,
        width: double.infinity,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFF407E8C),
              fontSize: 17,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
