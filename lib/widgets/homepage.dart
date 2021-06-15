import 'package:flutter/material.dart';
import 'package:tetris_game/Constants/constants.dart';
import 'package:tetris_game/widgets/game_box.dart';
import 'package:tetris_game/widgets/score_part.dart';

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'T E T R I S',
          style: kLableStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: kPrimaryColor200,
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GameBox(),
            ),
          ),
          Flexible(
            flex: 1,
            child: ScoreCardWidget(),
          ),
        ],
      ),
    );
  }
}
