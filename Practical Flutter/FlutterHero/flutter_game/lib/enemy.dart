// @dart=2.9

import "game_object.dart";

class Enemy extends GameObject {
  int speed = 0;
  int moveDirection = 0;

  Enemy(
      double inScreenWidth,
      double inScreenHeight,
      String inBaseFilename,
      int inWidth,
      int inHeight,
      int inNumFrames,
      int inFrameSkip,
      int inMoveDirection,
      int inSpeed)
      : super(inScreenWidth, inScreenHeight, inBaseFilename, inWidth, inHeight,
            inNumFrames, inFrameSkip, null) {
    speed = inSpeed;
    moveDirection = inMoveDirection;
  }

  void move() {
    if (moveDirection == 1) {
      x = x + speed;
      if (x > screenWidth + width) {
        x = -width.toDouble();
      }
    } else {
      x = x - speed;
      if (x < -width) {
        x = screenWidth + width.toDouble();
      }
    }
  }
}
