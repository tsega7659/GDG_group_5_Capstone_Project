class Product {
  final double id;
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
      id: (json['id'] is int) 
          ? (json['id'] as int).toDouble() 
          : (json['id'] as num).toDouble(), // Handle int or double
      title: json['title'] as String? ?? '',
      price: (json['price'] is int) 
          ? (json['price'] as int).toDouble() 
          : (json['price'] as num).toDouble(), // Handle int or double
      description: json['description'] as String?,
      image: json['image'] as String? ?? '',
    );
  }
}