class Restaurant {
  Restaurant(
      {required this.name, required this.cuisine, required this.ratings});

  final String name;
  final String cuisine;
  final List<double> ratings;

  int get numRatings => ratings.length;

  // Best practice - Use methods instead of get for complex operations:
  double? avgRating() {
    if (ratings.isEmpty) {
      return null;
    }

    return ratings.reduce((value, element) => value + element) / ratings.length;
  }
}
