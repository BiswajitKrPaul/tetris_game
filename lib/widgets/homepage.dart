import 'package:flutter/material.dart';
import 'package:tetris_game/Constants/constants.dart';
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
          'Tetris',
        ),
        centerTitle: true,
      ),
      backgroundColor: kPrimaryColor200,
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              color: Colors.red,
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
