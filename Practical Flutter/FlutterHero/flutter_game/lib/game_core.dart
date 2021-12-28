// @dart=2.9

import "dart:math";
import "package:flutter/material.dart";
import "package:audioplayers/audio_cache.dart";

import "input_controller.dart" as InputController;
import "game_object.dart";
import "enemy.dart";
import "player.dart";

State state;

Random random = Random();

int score = 0;

double screenWidth;
double screenHeight;

AnimationController gameLoopController;
Animation gameLoopAnimation;

GameObject crystal;

List fish;
List robots;
List aliens;
List asteroids;

Player player;

GameObject planet;

List explosions = [];

AudioCache audioCache;

void firstTimeInitialization(BuildContext inContext, dynamic inState) {
  state = inState;

  audioCache = AudioCache();
  audioCache
      .loadAll(["delivery.mp3", "explosion.mp3", "fill.mp3", "thrust.mp3"]);

  screenWidth = MediaQuery.of(inContext).size.width;
  screenHeight = MediaQuery.of(inContext).size.height;

  crystal =
      GameObject(screenWidth, screenHeight, "crystal", 32, 30, 4, 6, null);
  planet = GameObject(screenWidth, screenHeight, "planet", 64, 64, 1, 0, null);
  player = Player(screenWidth, screenHeight, "player", 40, 34, 2, 6, 2);

  fish = [
    Enemy(screenWidth, screenHeight, "fish", 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, "fish", 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, "fish", 48, 48, 2, 6, 1, 4)
  ];
  robots = [
    Enemy(screenWidth, screenHeight, "robot", 48, 48, 2, 6, 0, 3),
    Enemy(screenWidth, screenHeight, "robot", 48, 48, 2, 6, 0, 3),
    Enemy(screenWidth, screenHeight, "robot", 48, 48, 2, 6, 0, 3)
  ];
  aliens = [
    Enemy(screenWidth, screenHeight, "alien", 48, 48, 2, 6, 1, 2),
    Enemy(screenWidth, screenHeight, "alien", 48, 48, 2, 6, 1, 2),
    Enemy(screenWidth, screenHeight, "alien", 48, 48, 2, 6, 1, 2)
  ];
  asteroids = [
    Enemy(screenWidth, screenHeight, "asteroid", 48, 48, 2, 6, 0, 1),
    Enemy(screenWidth, screenHeight, "asteroid", 48, 48, 2, 6, 0, 1),
    Enemy(screenWidth, screenHeight, "asteroid", 48, 48, 2, 6, 0, 1)
  ];

  gameLoopController = AnimationController(
    vsync: inState,
    duration: const Duration(milliseconds: 1000),
  );

  gameLoopAnimation = Tween(begin: 0, end: 17).animate(
    CurvedAnimation(parent: gameLoopController, curve: Curves.linear),
  );

  gameLoopAnimation.addStatusListener((inStatus) {
    if (inStatus == AnimationStatus.completed) {
      gameLoopController.reset();
      gameLoopController.forward();
    }
  });

  gameLoopAnimation.addListener(gameLoop);

  resetGame(true);

  InputController.init(player);

  gameLoopController.forward();
}

void resetGame(bool inResetEnemies) {
  player.energy = 0.0;

  player.x = (screenWidth / 2) - (player.width / 2);
  player.y = screenHeight - player.height - 24;
  player.moveHorizontal = 0;
  player.moveVertical = 0;
  player.orientationChanged();

  crystal.y = 34.0;
  randomlyPositionObject(crystal);

  planet.y = screenHeight - planet.height - 10;
  randomlyPositionObject(planet);

  if (inResetEnemies) {
    List xValsFish = [70.0, 192.0, 312.0];
    List xValsRobots = [64.0, 192.0, 320.0];
    List xValsAliens = [44.0, 192.0, 340.0];
    List xValsAsteroids = [24.0, 192.0, 360.0];

    for (int i = 0; i < 3; i++) {
      fish[i].x = xValsFish[i];
      robots[i].x = xValsRobots[i];
      aliens[i].x = xValsAliens[i];
      asteroids[i].x = xValsAsteroids[i];

      fish[i].y = 110.0;
      robots[i].y = fish[i].y + 120;
      aliens[i].y = robots[i].y + 130;
      asteroids[i].y = aliens[i].y + 140;
      fish[i].visible = true;
      robots[i].visible = true;
      aliens[i].visible = true;
      asteroids[i].visible = true;
    }
  }

  explosions = [];

  player.visible = true;
}

void gameLoop() {
  crystal.animate();

  for (int i = 0; i < 3; i++) {
    fish[i].move();
    fish[i].animate();

    robots[i].move();
    robots[i].animate();

    aliens[i].move();
    aliens[i].animate();

    asteroids[i].move();
    asteroids[i].animate();
  }

  player.move();
  player.animate();

  for (int i = 0; i < explosions.length; i++) {
    explosions[i].animate();
  }

  if (collision(crystal)) {
    transferEnergy(true);
  } else if (collision(planet)) {
    transferEnergy(false);
  } else {
    if (player.energy > 0 && player.energy < 1) {
      player.energy = 0;
    }
  }

  for (int i = 0; i < 3; i++) {
    if (collision(fish[i]) ||
        collision(robots[i]) ||
        collision(aliens[i]) ||
        collision(asteroids[i])) {
      audioCache.play("explosion.mp3");
      player.visible = false;

      GameObject explosion =
          GameObject(screenWidth, screenHeight, "explosion", 50, 50, 5, 4, () {
        resetGame(false);
      });

      explosion.x = player.x;
      explosion.y = player.y;

      explosions.add(explosion);

      score = score - 50;

      if (score < 0) {
        score = 0;
      }
    }
  }

  state.setState(() {});
}

bool collision(GameObject inObject) {
  if (!player.visible || !inObject.visible) {
    return false;
  }

  num left1 = player.x;
  num right1 = left1 + player.width;
  num top1 = player.y;
  num bottom1 = top1 + player.height;
  num left2 = inObject.x;
  num right2 = left2 + inObject.width;
  num top2 = inObject.y;
  num bottom2 = top2 + inObject.height;

  if (bottom1 < top2) {
    return false;
  }
  if (top1 > bottom2) {
    return false;
  }
  if (right1 < left2) {
    return false;
  }

  return left1 <= right2;
}

void randomlyPositionObject(GameObject inObject) {
  inObject.x =
      (random.nextInt(screenWidth.toInt() - inObject.width)).toDouble();

  if (collision(inObject)) {
    randomlyPositionObject(inObject);
  }
}

void transferEnergy(bool inTouchingCrystal) {
  if (inTouchingCrystal && player.energy < 1) {
    if (player.energy == 0) {
      audioCache.play("fill.mp3");
    }

    player.energy = player.energy + .01;

    if (player.energy >= 1) {
      player.energy = 1;
      randomlyPositionObject(crystal);
    }
  } else if (player.energy > 0) {
    if (player.energy >= 1) {
      audioCache.play("delivery.mp3");
    }

    player.energy = player.energy - .01;

    if (player.energy <= 0) {
      player.energy = 0;
      audioCache.play("explosion.mp3");
      score = score + 100;

      for (int i = 0; i < 3; i++) {
        Function callback;

        if (i == 0) {
          callback = () {
            resetGame(true);
          };
        }

        fish[i].visible = false;
        GameObject explosion = GameObject(
            screenWidth, screenHeight, "explosion", 50, 50, 5, 4, callback);
        explosion.x = fish[i].x;
        explosion.y = fish[i].y;
        explosions.add(explosion);
        robots[i].visible = false;

        explosion = GameObject(
            screenWidth, screenHeight, "explosion", 50, 50, 5, 4, null);
        explosion.x = robots[i].x;
        explosion.y = robots[i].y;
        explosions.add(explosion);
        aliens[i].visible = false;

        explosion = GameObject(
            screenWidth, screenHeight, "explosion", 50, 50, 5, 4, null);
        explosion.x = aliens[i].x;
        explosion.y = aliens[i].y;
        explosions.add(explosion);
        asteroids[i].visible = false;

        explosion = GameObject(
            screenWidth, screenHeight, "explosion", 50, 50, 5, 4, null);
        explosion.x = asteroids[i].x;
        explosion.y = asteroids[i].y;
        explosions.add(explosion);
      }
    }
  }
}
