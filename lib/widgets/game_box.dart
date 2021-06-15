import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final score = StateProvider((ref) => 0);

class GameBox extends StatefulWidget {
  GameBox({Key key}) : super(key: key);
  @override
  GameBoxState createState() => GameBoxState();
}

class GameBoxState extends State<GameBox> {
  bool isPlaying = false;
  bool isGameOver = false;
  double subblockwidth;
  GlobalKey _gameAreaKey = GlobalKey();
  Duration duration = Duration(milliseconds: kGameSpeed);
  Timer timer;
  List<SubBlock> oldSubBlocks;
  BlockMovement blockMovement;
  GameBlock gameBlock;

  bool checkAtBottom() {
    return gameBlock.y + gameBlock.height == kTotalBlockColumn;
  }

  void startGame() {
    if (!isPlaying) {
      context.read(score).state = 0;
      oldSubBlocks = [];
      isPlaying = true;
      isGameOver = false;
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

  void updateScore() {
    var combo = 1;
    Map<int, int> rows = {};
    List<int> rowsToBeRemoved = [];

    oldSubBlocks?.forEach((element) {
      rows.update(element.y, (value) => ++value, ifAbsent: () => 1);
    });

    rows.forEach(
      (key, value) {
        if (value == kTotalBlockRow) {
          context.read(score).state += combo++;
          rowsToBeRemoved.add(key);
        }
      },
    );

    if (rowsToBeRemoved.length > 0) {
      removeRows(rowsToBeRemoved);
    }
  }

  void removeRows(List<int> rowsToRemove) {
    rowsToRemove.sort();
    rowsToRemove.forEach((subblock) {
      oldSubBlocks.removeWhere((element) => element.y == subblock);
      oldSubBlocks.forEach((subBlock) {
        ++subBlock.y;
      });
    });
  }

  bool checkAboveBlock() {
    for (var oldSubBlock in oldSubBlocks) {
      for (var sublock in gameBlock.subBlockOrientations) {
        var x = gameBlock.x + sublock.x;
        var y = gameBlock.y + sublock.y;
        if (x == oldSubBlock.x && y + 1 == oldSubBlock.y) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkOnEdge(BlockMovement action) {
    return (action == BlockMovement.LEFT && gameBlock.x <= 0) ||
        (action == BlockMovement.RIGHT &&
            gameBlock.x + gameBlock.width >= kTotalBlockRow);
  }

  void onPlay(timer) {
    var status;
    setState(
      () {
        if (blockMovement != null) {
          if (!checkOnEdge(blockMovement)) {
            gameBlock.move(blockMovement);
          }
        }

        for (var oldSubBlock in oldSubBlocks) {
          for (var subBlock in gameBlock.subBlockOrientations) {
            var x = gameBlock.x + subBlock.x;
            var y = gameBlock.y + subBlock.y;
            if (x == oldSubBlock.x && y == oldSubBlock.y) {
              switch (blockMovement) {
                case BlockMovement.LEFT:
                  gameBlock.move(BlockMovement.RIGHT);
                  break;
                case BlockMovement.RIGHT:
                  gameBlock.move(BlockMovement.LEFT);
                  break;
                case BlockMovement.ROTATE_CLOCKWISE:
                  gameBlock.move(BlockMovement.ROTATE_COUNTER_CLOCKWISE);
                  break;
                default:
                  break;
              }
            }
          }
        }

        if (checkAtBottom()) {
          status = Collision.LANDED;
        } else {
          if (!checkAboveBlock()) {
            gameBlock.move(BlockMovement.DOWN);
          } else {
            status = Collision.LANDED_BLOCK;
          }
        }

        if (status == Collision.LANDED_BLOCK && gameBlock.y < 0) {
          isGameOver = true;
          endGame();
        }
        if (status == Collision.LANDED || status == Collision.LANDED_BLOCK) {
          gameBlock.subBlockOrientations.forEach((subblock) {
            subblock.x += gameBlock.x;
            subblock.y += gameBlock.y;
            oldSubBlocks.add(subblock);
          });
          gameBlock = getNewGameBlock();
        }
        blockMovement = null;
        updateScore();
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

    if (isGameOver) {
      subblocks.add(getGameOverRect());
    }

    return Stack(
      children: subblocks,
    );
  }

  Widget getGameOverRect() {
    return Positioned(
      child: Center(
        child: Container(
          width: subblockwidth * 8.0,
          height: subblockwidth * 4.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            'GAME OVER',
            style: kButtonLableStyle,
          ),
        ),
      ),
      left: subblockwidth * 2.0,
      top: subblockwidth * 6.0,
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
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            blockMovement = BlockMovement.RIGHT;
          } else {
            blockMovement = BlockMovement.LEFT;
          }
        },
        onTap: () {
          blockMovement = BlockMovement.ROTATE_CLOCKWISE;
        },
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
      ),
    );
  }
}
