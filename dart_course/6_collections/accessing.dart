main() {
  final colors = ["grey", "brown"];

  const addBlue = false;
  const addRed = true;

  if (addBlue) {
    colors.add("blue");
  }

  if (addRed) {
    colors.add("red");
  }

  print(colors);

  const extraColors = ["yellow", "green"];
  const extraColors2 = ["pink", "black"];
  const extraColors3 = ["orange", "purple"];

  // Collection-if, collection-for and spreads:
  final colors2 = [
    "grey",
    "brown",
    if (addBlue) "blue",
    if (addRed) "red",
    for (var color in extraColors2) color,
    ...extraColors3
  ];

  // Add a list inside another list:
  colors2.addAll(extraColors);

  print(colors2);

  const ratings = [4.0, 4.5, 3.5];

  final restaurant = {
    "name": "Pizza Mario",
    "cuisine": "Italian",
    if (ratings.length > 3) ...{"ratings": ratings, "isPopular": true}
  };

  print(restaurant);
}
