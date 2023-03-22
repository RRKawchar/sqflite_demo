class CartModel {
  String? id;
  String? name;
  String? price;
  String? description;
  String? image;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
    };
  }

  static CartModel fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
    );
  }
}
