import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/Gameblocks/game_block.dart';
import 'package:tetris_game/Gameblocks/i_block.dart';
import 'package:tetris_game/Gameblocks/j_block.dart';
import 'package:tetris_game/Gameblocks/l_block.dart';
import 'package:tetris_game/Gameblocks/o_block.dart';
import 'package:tetris_game/Gameblocks/s_block.dart';
import 'package:tetris_game/Gameblocks/sub_block.dart';
import 'package:tetris_game/Gameblocks/t_block.dart';
import '../Constants/constants.dart';

enum Collision { LANDED, LANDED_BLOCK, HIT_WALL, HIT_BLOCK, NONE }

class GameBox extends StatefulWidget {
  GameBox({Key key}) : super(key: key);
  @override
  GameBoxState createState() => GameBoxState();
}

class GameBoxState extends State<GameBox> {
  bool isPlaying = false;
  double subblockwidth;
  GlobalKey _gameAreaKey = GlobalKey();
  Duration duration = Duration(milliseconds: kGameSpeed);
  Timer timer;
  List<SubBlock> oldSubBlocks;

  GameBlock gameBlock;

  bool checkAtBottom() {
    return gameBlock.y + gameBlock.height == kTotalBlockColumn;
  }

  void startGame() {
    if (!isPlaying) {
      oldSubBlocks = [];
      isPlaying = true;
      RenderBox renderBox = _gameAreaKey.currentContext.findRenderObject();
      subblockwidth =
          (renderBox.size.width - kGameAreaBorder * 2) / kTotalBlockRow;

      gameBlock = getNewGameBlock();

      timer = Timer.periodic(duration, onPlay);
    }
  }

  void endGame() {
    if (isPlaying) {
      isPlaying = false;
      timer.cancel();
    }
  }

  void onPlay(timer) {
    var status;
    setState(
      () {
        if (checkAtBottom()) {
          status = Collision.LANDED;
        } else {
          gameBlock.move(BlockMovement.DOWN);
        }

        if (status == Collision.LANDED) {
          gameBlock.subBlockOrientations.forEach((subblock) {
            subblock.x += gameBlock.x;
            subblock.y += gameBlock.y;
            oldSubBlocks.add(subblock);
          });
          gameBlock = getNewGameBlock();
        }
      },
    );
  }

  Widget getPositionedSquareContainer(int x, int y, Color color) {
    return Positioned(
      left: x * subblockwidth,
      top: y * subblockwidth,
      child: Container(
        width: subblockwidth - kGameAreaBorder,
        height: subblockwidth - kGameAreaBorder,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget drawBlock() {
    if (gameBlock == null) return null;
    List<Positioned> subblocks = [];

    gameBlock.subBlockOrientations.forEach(
      (subblock) {
        subblocks.add(
          getPositionedSquareContainer(subblock.x + gameBlock.x,
              subblock.y + gameBlock.y, subblock.color),
        );
      },
    );

    oldSubBlocks?.forEach((element) {
      subblocks.add(
          getPositionedSquareContainer(element.x, element.y, element.color));
    });

    return Stack(
      children: subblocks,
    );
  }

  GameBlock getNewGameBlock() {
    int blockNumber = Random().nextInt(7);
    int orientationNumber = Random().nextInt(4);

    switch (blockNumber) {
      case 0:
        return IBlock(orientationNumber);
        break;
      case 1:
        return JBlock(orientationNumber);
        break;
      case 2:
        return LBlock(orientationNumber);
        break;
      case 3:
        return OBlock(orientationNumber);
        break;
      case 4:
        return SBlock(orientationNumber);
        break;
      case 5:
        return TBlock(orientationNumber);
        break;
      case 6:
        return SBlock(orientationNumber);
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AspectRatio(
        aspectRatio: kTotalBlockRow / kTotalBlockColumn,
        child: Container(
          key: _gameAreaKey,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: kGameAreaBorder.toDouble(),
              color: kPrimaryColor500,
            ),
          ),
          child: drawBlock(),
        ),
      ),
    );
  }
}
