import 'package:flutter/material.dart';
import 'package:tetris_game/Gameblocks/game_block.dart';
import 'package:tetris_game/Gameblocks/sub_block.dart';

class OBlock extends GameBlock {
  OBlock(int orientationIndex)
      : super(orientations: [
          [
            SubBlock(0, 0),
            SubBlock(1, 0),
            SubBlock(0, 1),
            SubBlock(1, 1),
          ],
          [
            SubBlock(0, 0),
            SubBlock(1, 0),
            SubBlock(0, 1),
            SubBlock(1, 1),
          ],
          [
            SubBlock(0, 0),
            SubBlock(1, 0),
            SubBlock(0, 1),
            SubBlock(1, 1),
          ],
          [
            SubBlock(0, 0),
            SubBlock(1, 0),
            SubBlock(0, 1),
            SubBlock(1, 1),
          ],
        ], color: Colors.blue[300], orientationIndex: orientationIndex);
}
