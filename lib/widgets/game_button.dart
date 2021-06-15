import 'package:flutter/material.dart';
import 'package:tetris_game/Constants/constants.dart';

class GameButton extends StatelessWidget {
  final Function gameFunction;
  final String buttonTitle;

  GameButton({
    @required this.buttonTitle,
    @required this.gameFunction,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: gameFunction,
      child: Text(
        buttonTitle,
        style: kButtonLableStyle,
      ),
      constraints: BoxConstraints.tight(
        Size(130, 100),
      ),
      padding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      fillColor: kPrimaryColor400,
      splashColor: kPrimaryColor300,
    );
  }
}
