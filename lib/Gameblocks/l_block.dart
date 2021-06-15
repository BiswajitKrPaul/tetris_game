import 'package:flutter/material.dart';
import 'package:tetris_game/Gameblocks/game_block.dart';
import 'package:tetris_game/Gameblocks/sub_block.dart';

class LBlock extends GameBlock {
  LBlock(int orientationIndex)
      : super(
          orientations: [
            [
              SubBlock(0, 0),
              SubBlock(0, 1),
              SubBlock(0, 2),
              SubBlock(1, 2),
            ],
            [
              SubBlock(0, 0),
              SubBlock(1, 0),
              SubBlock(2, 0),
              SubBlock(0, 1),
            ],
            [
              SubBlock(0, 0),
              SubBlock(1, 0),
              SubBlock(1, 1),
              SubBlock(1, 2),
            ],
            [
              SubBlock(2, 0),
              SubBlock(0, 1),
              SubBlock(1, 1),
              SubBlock(2, 1),
            ],
          ],
          color: Colors.green[300],
          orientationIndex: orientationIndex,
        );
}
