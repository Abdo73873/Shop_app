class HomeModel{

late bool status;
late HomeModelData data;
HomeModel.fromJson( Map<String,dynamic> json){
  status=json["status"];
  data=HomeModelData.fromJson(json["data"]);
}

}
class HomeModelData{
  List<BannersModel> banners=[];
   List<ProductsModel> products=[];
  String? ad;
  HomeModelData.fromJson(Map<String,dynamic> json){
    ad=json["ad"];
    json["banners"].forEach((element){
      banners.add(BannersModel.fromJson(element));
    });

    for(Map<String,dynamic> element in json["products"]){
      products.add(ProductsModel.fromJson(element));
    }


  }

}
class BannersModel{
 late int id;
 String? image;
 BannersModel.fromJson(Map<String,dynamic> json){
   id=json["id"];
   image=json["image"];
 }

}
class ProductsModel{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  late bool intFavorites;
  late bool inCart;
  String? description;
  List<String>? images=[];
  ProductsModel.fromJson(Map<String,dynamic> json){
    id=json["id"];
    price=json["price"];
  oldPrice=json["old_price"];
  discount=json["discount"];
  image=json["image"];
  name=json["name"];
  intFavorites=json["in_favorites"];
  inCart=json["in_cart"];
  description=json["description"];
    images=json["images"].cast<String>();

  }






}