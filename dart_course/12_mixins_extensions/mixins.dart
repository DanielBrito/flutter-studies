// Note: mixins can't be instantiated:

mixin Swimming {
  void swim() => print("swimming...");
}

mixin Breathing {
  void breathe() => print("breathing...");
}

class Animal with Breathing {}

class Plant with Breathing {}

class Fish extends Animal with Swimming {}

class Human extends Animal with Swimming {}

main() {
  final fish = Fish();
  fish.swim();

  final human = Human();
  human.swim();
}
