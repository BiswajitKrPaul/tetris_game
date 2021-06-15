import 'package:flutter/material.dart';
import '../Constants/constants.dart';

class GameBox extends StatefulWidget {
  @override
  _GameBoxState createState() => _GameBoxState();
}

class _GameBoxState extends State<GameBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AspectRatio(
        aspectRatio: kTotalBlockRow / kTotalBlockColumn,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: 3,
              color: kPrimaryColor500,
            ),
          ),
        ),
      ),
    );
  }
}
