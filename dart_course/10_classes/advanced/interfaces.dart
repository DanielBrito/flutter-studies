// Extends: single type, must override abstract methods, can override concrete methods

// Implements: multiple types, must override abstract methods, must override concrete methods

abstract class InterfaceA {
  void a();
}

abstract class InterfaceB {
  void b();
}

class AB implements InterfaceA, InterfaceB {
  @override
  void a() {
    print("a");
  }

  @override
  void b() {
    print("b");
  }
}

abstract class Base {
  void foo();
  void bar() => print("bar");
}

class SubclassA extends Base {
  @override
  void foo() {
    print("foo");
  }
}

class SubclassB implements Base {
  @override
  void foo() {
    print("foo");
  }

  @override
  void bar() {
    print("bar: implements");
  }
}
