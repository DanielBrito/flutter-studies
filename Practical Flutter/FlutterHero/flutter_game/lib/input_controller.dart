// @dart=2.9

import "package:flutter/material.dart";

import "player.dart";

double touchAnchorX;
double touchAnchorY;

int moveSensitivity = 20;

Player player;

void init(Player inPlayer) {
  player = inPlayer;
}

void onPanStart(DragStartDetails inDetails) {
  touchAnchorX = inDetails.globalPosition.dx;
  touchAnchorY = inDetails.globalPosition.dy;

  player.moveHorizontal = 0;
  player.moveVertical = 0;
}

void onPanUpdate(DragUpdateDetails inDetails) {
  if (inDetails.globalPosition.dx < touchAnchorX - moveSensitivity) {
    player.moveHorizontal = -1;
    player.orientationChanged();
  } else if (inDetails.globalPosition.dx > touchAnchorX + moveSensitivity) {
    player.moveHorizontal = 1;
    player.orientationChanged();
  } else {
    player.moveHorizontal = 0;
    player.orientationChanged();
  }
  if (inDetails.globalPosition.dy < touchAnchorY - moveSensitivity) {
    player.moveVertical = -1;
    player.orientationChanged();
  } else if (inDetails.globalPosition.dy > touchAnchorY + moveSensitivity) {
    player.moveVertical = 1;
    player.orientationChanged();
  } else {
    player.moveVertical = 0;
    player.orientationChanged();
  }
}

void onPanEnd(dynamic inDetails) {
  player.moveHorizontal = 0;
  player.moveVertical = 0;
}
