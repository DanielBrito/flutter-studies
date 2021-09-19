// Composition <-> HAS-A relationships
// Inheritance <-> IS-A relationships

abstract class Widget {}

// Inheritance:
class Text extends Widget {
  Text(this.text);

  final String text;
}

class Button extends Widget {
  Button({required this.child, this.onPressed});

  final Widget child;
  final void Function()? onPressed;
}

main() {
  // Flutter uses composition (Text) to create complex UIs:
  final button =
      Button(child: Text("Hello"), onPressed: () => print("Button pressed!"));
}
