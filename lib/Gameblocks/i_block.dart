import 'package:flutter/material.dart';
import 'package:tetris_game/Gameblocks/sub_block.dart';

import 'game_block.dart';

class IBlock extends GameBlock {
  IBlock(int orientationIndex)
      : super(
          orientationIndex: orientationIndex,
          color: Colors.red,
          orientations: [
            [
              SubBlock(0, 0),
              SubBlock(0, 1),
              SubBlock(0, 2),
              SubBlock(0, 3),
            ],
            [
              SubBlock(0, 0),
              SubBlock(1, 0),
              SubBlock(2, 0),
              SubBlock(3, 0),
            ],
            [
              SubBlock(0, 0),
              SubBlock(0, 1),
              SubBlock(0, 2),
              SubBlock(0, 3),
            ],
            [
              SubBlock(0, 0),
              SubBlock(1, 0),
              SubBlock(2, 0),
              SubBlock(3, 0),
            ],
          ],
        );
}
