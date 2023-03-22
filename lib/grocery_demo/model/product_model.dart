class Product {
  int id;
  String name;
  String image;
  bool isFavorite;

  Product({required this.id, required this.name, required this.image, required this.isFavorite});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFavorite': isFavorite ? 1
          : 0
    };
  }

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        isFavorite: map['isFavorite'] == 1);
  }
}