// @dart=2.9

import "package:flutter/material.dart";

class GameObject {
  double screenWidth = 0.0;

  double screenHeight = 0.0;

  String baseFilename = "";

  int width = 0;

  int height = 0;

  double x = 0.0;

  double y = 0.0;

  int numFrames = 0;

  int frameSkip = 0;

  Function animationCallback;

  int currentFrame = 0;

  int frameCount = 0;

  List frames = [];

  bool visible = true;

  GameObject(
      double inScreenWidth,
      double inScreenHeight,
      String inBaseFilename,
      int inWidth,
      int inHeight,
      int inNumFrames,
      int inFrameSkip,
      Function inAnimationCallback) {
    screenWidth = inScreenWidth;
    screenHeight = inScreenHeight;
    baseFilename = inBaseFilename;
    width = inWidth;
    height = inHeight;
    numFrames = inNumFrames;
    frameSkip = inFrameSkip;
    animationCallback = inAnimationCallback;

    for (int i = 0; i < inNumFrames; i++) {
      frames.add(Image.asset("assets/$baseFilename-$i.png"));
    }
  }

  void animate() {
    frameCount = frameCount + 1;

    if (frameCount > frameSkip) {
      frameCount = 0;
      currentFrame = currentFrame + 1;

      if (currentFrame == numFrames) {
        currentFrame = 0;

        if (animationCallback != null) {
          animationCallback();
        }
      }
    }
  }

  Widget draw() {
    return visible
        ? Positioned(left: x, top: y, child: frames[currentFrame])
        : Positioned(child: Container());
  }
}
