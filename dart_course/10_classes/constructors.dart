// Positional optional parameters:
class UserA {
  String name;
  int age;
  String home;

  UserA(this.name, this.age, [this.home = "Earth"]);
}

// Optional parameters need to be nullable a default value is not provided:
class UserB {
  String name;
  int age;
  String? home;

  UserB(this.name, this.age, [this.home]);
}

// Named optional parameters (follows the same nullable idea):
class UserC {
  String name;
  int age;
  String? home;

  UserC(this.name, this.age, {this.home});
}

// Private fields:
class UserD {
  int? _id;

  UserD([this._id]);
}

class UserE {
  int _id;
  String? _name;

  UserE({required int id, String? name})
      : _id = id,
        _name = name;
}

// Named required parameters:
class UserF {
  String name;
  int age;
  String? home;

  UserF({required this.name, required this.age, this.home = "Earth"});
}

/* ------------------------------------------------------------------------- */

main() {
  UserA user1 = UserA("Daniel", 28);
  UserA user2 = UserA("Daniel", 29, "Mars");

  UserB user3 = UserB("Daniel", 28);
  UserB user4 = UserB("Daniel", 29, "Mars");

  UserC user5 = UserC("Daniel", 28);
  UserC user6 = UserC("Daniel", 29, home: "Mars");

  UserD user7 = UserD(3);

  UserE user8 = UserE(id: 10, name: "Daniel");

  UserF user9 = UserF(name: "Daniel", age: 34);
  UserF user10 = UserF(name: "Daniel", age: 37, home: "Neptune");
}
