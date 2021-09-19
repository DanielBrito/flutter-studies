// Problem - Mutable global state:
var counter = 1;

// This function has a side effect
//Prints different values each time its called
void foo() {
  print("*" * counter);
  counter++;
}

main() {
  foo(); // *
  foo(); // **
  foo(); // ***
}
