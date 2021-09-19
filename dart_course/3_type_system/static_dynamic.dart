main() {
  print("Static: types are checked at compile time");
  print("Dynamic: types are checked on the fly, during execution (at runtime)");

  // var -> can set more than once (allowing type inference):
  var name = "Daniel";
  var age = 28;
  var height = 1.76;

  // final -> can be set only once:
  final isHuman = true;

  // const -> compile-time constants:
  const x = 1;
  const y = 2;
  const z = x + y;

  // Best practice:
  print("const > final > var");

  // Dynamic keyword (specific in some cases - JSON):

  var a = 10;
  // a = true; // Error

  dynamic b = 10;
  b = true;
}
