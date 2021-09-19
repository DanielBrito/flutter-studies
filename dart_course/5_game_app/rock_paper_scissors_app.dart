import 'dart:io';

import 'dart:math';

enum Move { rock, paper, scissors }

main() {
  final rng = Random();

  while (true) {
    stdout.write("Rock, paper or scissors? (r/p/s): ");

    final input = stdin.readLineSync();

    if (input == "r" || input == "p" || input == "s") {
      var playerMove;

      switch (input) {
        case "r":
          playerMove = Move.rock;
          break;
        case "p":
          playerMove = Move.paper;
          break;
        case "s":
          playerMove = Move.scissors;
          break;
      }

      final random = rng.nextInt(3);

      final aiMove = Move.values[random];

      print("Your move: $playerMove");
      print("AI move: $aiMove");

      if (playerMove == aiMove) {
        print("Draw");
      } else if (playerMove == Move.rock && aiMove == Move.scissors ||
          playerMove == Move.paper && aiMove == Move.rock ||
          playerMove == Move.scissors && aiMove == Move.paper) {
        print("You win");
      } else {
        print("You loose");
      }
    } else if (input == "q") {
      break;
    } else {
      print("Invalid input");
    }
  }
}
