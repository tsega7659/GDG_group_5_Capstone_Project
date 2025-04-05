class Product {
  final double id; // Kept as int since API returns integer
  final String title;
  final double price;
  final String? description;
  final String image;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    required this.image,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id:
          json['id'] is double
              ? json['id'] as double
              : double.parse(
                json['id'].toString(),
              ), // Handle both int and string cases
      title: json['title'] as String? ?? '', // Fallback to empty string if null
      price:
          (json['price'] is num
                  ? json['price']
                  : double.parse(json['price'].toString()))
              as double, // Handle number parsing
      description: json['description'] as String?, // Nullable
      image: json['image'] as String? ?? '', // Fallback to empty string if null
    );
  }
}
