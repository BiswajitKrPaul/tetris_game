import 'package:flutter/material.dart';
import 'package:tetris_game/Gameblocks/sub_block.dart';

enum BlockMovement {
  UP,
  DOWN,
  LEFT,
  RIGHT,
  ROTATE_CLOCKWISE,
  ROTATE_COUNTER_CLOCKWISE
}

class GameBlock {
  // inner list= 4 orientations of blocks
  //outer list = all 7 blocks formed by sub blocks
  List<List<SubBlock>> orientations = [];
  int x;
  int y;
  int orientationIndex;

  GameBlock({this.orientations, Color color, this.orientationIndex}) {
    x = 3;
    y = -height;
    this.color = color;
  }

  // setting each block colour(same colour)
  set color(Color color) {
    orientations.forEach(
      (blocks) {
        blocks.forEach((subblock) {
          subblock.color = color;
        });
      },
    );
  }

  // Getting the color for 1st subblock
  get color {
    return orientations[0][0];
  }

  // Getting the Orientation list of the current index block
  get subBlockOrientations {
    return orientations[orientationIndex];
  }

  //getting maximum width of the current orientation
  get width {
    int maxX = 0;
    subBlockOrientations.forEach(
      (subblocks) {
        if (subblocks.x > maxX) {
          maxX = subblocks.x;
        }
      },
    );
    return maxX + 1;
  }

  //getting maximum height of the current orientation
  get height {
    int maxY = 0;
    subBlockOrientations.forEach(
      (subblocks) {
        if (subblocks.y > maxY) {
          maxY = subblocks.y;
        }
      },
    );
    return maxY + 1;
  }

  // Block Move function
  void move(BlockMovement blockMovement) {
    switch (blockMovement) {
      case BlockMovement.DOWN:
        y++;
        break;
      case BlockMovement.UP:
        y--;
        break;
      case BlockMovement.RIGHT:
        x++;
        break;
      case BlockMovement.LEFT:
        x--;
        break;
      case BlockMovement.ROTATE_CLOCKWISE:
        orientationIndex = (++orientationIndex) % 4;
        break;
      case BlockMovement.ROTATE_COUNTER_CLOCKWISE:
        orientationIndex = (orientationIndex + 3) % 4;
        break;
    }
  }
}
