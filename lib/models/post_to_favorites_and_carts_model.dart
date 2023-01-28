class PostToFavoritesModel {
  late bool status;
  String? message;
  PostToFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}

class PostToCartModel {
  late bool status;
  String? message;
  PostToCartModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
