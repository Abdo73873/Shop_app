//base url: https://newsapi.org/
// method url : v2/top-headlines?
// queries : country=eg&category=business&apiKey=498af28f8af946e6b204c6c806e8cfcb
// api for searching https://newsapi.org/v2/everything?q=tesla&apiKey=498af28f8af946e6b204c6c806e8cfcb
/*{"status": "ok",
"totalResults": 15,
"articles": [
{
"source": {"id": null,"name": "Elaosboa.com"},
"author": "الأسبوع",
"title": "بعد صعوده فجأة.. سعر الدولار في مصر خلال منتصف تعاملات اليوم السبت - الأسبوع",
"description": "الدولار في مصر.. استقر سعر الدولار في مصر مقابل الجنيه المصري خلال منتصف تعاملات اليوم السبت 14 يناير في معظم البنوك المتواجدة، بينما سجل أعلى سعر عند مستويات 29.55 جنيه…",
"url": "https://www.elaosboa.com/675830/",
"urlToImage": "https://www.elaosboa.com/wp-content/uploads/2022/12/elaosboa91864.jpg",
"publishedAt": "2023-01-14T12:43:17Z",
"content": "<ol><li></li><li></li></ol>.. 14 29.55 32.05 11 .\r\n 29.50 29.65 .\r\n «» .\r\n29.65 .\r\n29.52 29.65 29.74 .\r\n 29.50 29.55 .\r\n 29.50 .\r\n 29.65 .\r\n 29.50 29.60 .\r\n :\r\n 14 \r\n .. 14"
},}*/

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        /* headers: {
            'Content-Type': 'application/json',
          }*/
      ),
    );
  }

  static Future<Response> getData({
    required String urlPath,
    Map<String, dynamic>? query,
    String? language,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token,
    };
    return await dio.get(
      '${Uri(path: urlPath)}',
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String urlPath,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? language,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token,
    };

    return await dio.post(
      '${Uri(path: urlPath)}',
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String urlPath,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? language,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token,
    };

    return await dio.put(
      '${Uri(path: urlPath)}',
      data: data,
      queryParameters: query,
    );
  }
}
