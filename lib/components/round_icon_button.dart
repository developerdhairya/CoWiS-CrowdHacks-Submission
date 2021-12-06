import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed,Key? key}) : super(key: key);

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Icon(
        icon,
        color: Colors.white,
      ),
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(width: 46, height: 46),
      fillColor: Colors.teal,
      elevation: 6,
    );
  }
}