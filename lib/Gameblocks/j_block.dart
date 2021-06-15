import 'package:flutter/material.dart';
import 'package:tetris_game/Gameblocks/game_block.dart';
import 'package:tetris_game/Gameblocks/sub_block.dart';

class JBlock extends GameBlock {
  JBlock(int orientationIndex)
      : super(
          orientationIndex: orientationIndex,
          color: Colors.yellow,
          orientations: [
            [
              SubBlock(1, 0),
              SubBlock(1, 1),
              SubBlock(1, 2),
              SubBlock(0, 2),
            ],
            [
              SubBlock(0, 0),
              SubBlock(0, 1),
              SubBlock(1, 1),
              SubBlock(2, 1),
            ],
            [
              SubBlock(0, 0),
              SubBlock(1, 0),
              SubBlock(0, 1),
              SubBlock(0, 2),
            ],
            [
              SubBlock(0, 0),
              SubBlock(1, 0),
              SubBlock(2, 0),
              SubBlock(2, 1),
            ],
          ],
        );
}
