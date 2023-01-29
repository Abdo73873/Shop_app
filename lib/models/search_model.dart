class SearchModel {
  late bool status;
  String? message;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  int? currentPage;
  List<Data> data = [];

  SearchData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(Data.fromJson(v));
    });
  }
}


class Data {
  late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  late String name;
  String? description;
   List<String>? images=[];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
  }
}
