class Product {
  final int id;
  final String title;
  final double price;
  final String? description; // Nullable, from HEAD
  final String category; // From eyosi-signup
  final String image;
  bool isFavorite; // From HEAD

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description, // Optional, from HEAD
    required this.category, // Required, from eyosi-signup
    required this.image,
    this.isFavorite = false, // Default value from HEAD
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int, // Strict int, common in APIs
      title: json['title'] as String? ?? '', // Fallback to empty string
      price:
          (json['price'] is int)
              ? (json['price'] as int).toDouble()
              : (json['price'] as num)
                  .toDouble(), // Flexible handling from HEAD
      description: json['description'] as String?, // Nullable, from HEAD
      category: json['category'] as String? ?? 'Uncategorized', // Fallback
      image: json['image'] as String? ?? '', // Fallback to empty string
      isFavorite: json['isFavorite'] as bool? ?? false, // From HEAD
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'isFavorite': isFavorite, // From HEAD
    };
  }
}
