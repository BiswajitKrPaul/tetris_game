import 'package:flutter/material.dart';
import 'package:tetris_game/Constants/constants.dart';
import 'package:tetris_game/widgets/game_box.dart';
import 'package:tetris_game/widgets/game_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  GlobalKey<GameBoxState> key = GlobalKey();
  GlobalKey<GameBoxState> key2 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    int gameScore = context.read(score).state;
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
              child: GameBox(
                key: key,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
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
                          '$gameScore',
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
                          gameFunction: () {
                            setState(() {
                              key.currentState.startGame();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: GameButton(
                          buttonTitle: 'E N D',
                          gameFunction: () {
                            setState(() {
                              key.currentState.endGame();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
