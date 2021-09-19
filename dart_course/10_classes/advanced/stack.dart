// Stack implementation with generics <T>.
class Stack<T> {
  // Using composition: a stack HAS-A list.
  final List<T> _items = [];

  void push(T item) => _items.add(item);

  T pop() => _items.removeLast();
}

main() {
  final stack = Stack<int>();

  stack.push(1);
  stack.push(2);

  print(stack.pop());
  print(stack.pop());

  final names = Stack<String>();

  names.push("Daniel");
  names.push("Brito");

  print(names.pop());
  print(names.pop());
}
