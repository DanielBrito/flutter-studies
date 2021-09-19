class Animal {
  const Animal({required this.age});

  final int age;

  void sleep() => print("sleeping...");
  void eat() => print("eating...");
  void move() => print("moving...");
}

class Dog extends Animal {
  Dog({required int age}) : super(age: age);

  void bark() => print("barking...");

  @override
  void sleep() => print("dog is sleeping");
}

class Cow extends Animal {
  Cow({required int age}) : super(age: age);

  void moo() => print("mooing...");
}

class CleverDog extends Dog {
  CleverDog({required int age}) : super(age: age);

  void catchBall() => print("catching ball...");
}

main() {
  final animal = Animal(age: 10);
  animal.sleep();

  final dog = Dog(age: 11);
  dog.bark();
  dog.sleep();

  final cow = Cow(age: 12);
  cow.eat();
  cow.moo();

  final cleverDog = CleverDog(age: 13);
  cleverDog.catchBall();
  cleverDog.bark();
  cleverDog.move();
}
