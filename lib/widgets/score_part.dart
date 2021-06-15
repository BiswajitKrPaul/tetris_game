import 'package:flutter/material.dart';
import 'package:tetris_game/Constants/constants.dart';
import 'package:tetris_game/widgets/game_button.dart';

class ScoreCardWidget extends StatefulWidget {
  @override
  _ScoreCardWidgetState createState() => _ScoreCardWidgetState();
}

class _ScoreCardWidgetState extends State<ScoreCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Score : ',
                  style: kLableStyle,
                ),
              ),
              Flexible(
                child: Text(
                  '0',
                  style: kLableStyle,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: GameButton(
                  buttonTitle: 'S T A R T',
                  gameFunction: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: GameButton(
                  buttonTitle: 'E N D',
                  gameFunction: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
