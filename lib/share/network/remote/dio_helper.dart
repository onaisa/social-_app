import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response<dynamic>> getData({
    String url,
    Map<String, dynamic> query,
    String token,
    String lang = 'en',
  }) async {
    String localToken = token;
    dio.options.headers = {
      'lang': lang,
      'Authorization': localToken ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response<dynamic>> postData({
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
