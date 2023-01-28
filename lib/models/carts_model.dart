class CartsModel {
  late bool status;
  String? message;
  CartsData? data;

  CartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data']!=null?CartsData.fromJson(json['data']):null;
  }
}

class CartsData {
  List<CartItems> cartItems = [];
  dynamic subTotal;
  dynamic total;

  CartsData.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((v) {
      cartItems.add(CartItems.fromJson(v));
    });
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
   int? id;
   int? quantity;
  late Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  late String name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
