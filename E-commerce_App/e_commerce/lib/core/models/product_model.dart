class Product {
  final int id;
  final String title;
  final double price;
  final String? description; 
  final String category; 
  final String image;
  bool isFavorite; 

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description, 
    required this.category, 
    required this.image,
    this.isFavorite = false, 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int, 
      title: json['title'] as String? ?? '', 
      price:
          (json['price'] is int)
              ? (json['price'] as int).toDouble()
              : (json['price'] as num)
                  .toDouble(), 
      description: json['description'] as String?,
      category: json['category'] as String? ?? 'Uncategorized', 
      image: json['image'] as String? ?? '', 
      isFavorite: json['isFavorite'] as bool? ?? false, 
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
      'isFavorite': isFavorite, 
    };
  }
}
