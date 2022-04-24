class Category {
  final String icon, title;

  Category({
    required this.icon,
    required this.title,
  });
}

// ignore: non_constant_identifier_names
List<Category> home_categories = [
  Category(
    icon: "assets/icons/ic_beach.svg",
    title: "Beach",
  ),
  Category(
    icon: "assets/icons/ic_mountain.svg",
    title: "Mountain",
  ),
  Category(
    icon: "assets/icons/ic_island.svg",
    title: "Island",
  ),
  Category(
    icon: "assets/icons/ic_city.svg",
    title: "City",
  ),
];
