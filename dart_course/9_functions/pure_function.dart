// Always produces the same result when called with the same arguments
// Doesn't mutate any variables outside its own scope

void foo() {
  var counter = 0;
  counter++;

  print("*" * counter);
}

main() {
  foo(); // *
  foo(); // *
  foo(); // *
}
