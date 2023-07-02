class CartItemModel {
  String? itemId;
  String? productId;
  String? image;
  String? name;
  num? price;
  int? quantity;


  CartItemModel(this.itemId, this.productId, this.quantity, this.image,
      this.price, this.name);

  CartItemModel.fromMap(Map<String, dynamic> data) {
    itemId = data["itemId"];
    productId = data["productId"];
    quantity = data["quantity"];
    image = data["image"];
    name = data["name"];
    price = data["price"];
  }
  Map<String, dynamic> toJson() {
    return {
      "itemId": itemId,
      "productId": productId,
      "quantity": quantity,
      "image": image,
      "name": name,
      "price": price
    };
  }
}
