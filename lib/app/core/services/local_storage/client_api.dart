import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:first/app/core/services/local_storage/get_storage_local_db.dart';

class ClientApi {

  Future<Dio> getClient() async {
    // Dio dio = Dio(getOptions(await LocalStorage().getTokenFromDisk));
    Dio dio = Dio(getOptions());

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requestInterceptors(options);
      return handler.next(options);
    }));
    return dio;
  }
}

dynamic requestInterceptors(RequestOptions options) async {
  if (options.headers.containsKey('auth')) {
    String token= await GetStorageLocalDb.getToken();
    log(token);
    //جلب التوكن من getStorage
    options.headers.addAll({'Authorization': 'Bearer $token'});
  }
}

BaseOptions getOptions() {
  return BaseOptions(
    sendTimeout: const Duration(milliseconds: 1500000),
    connectTimeout: const Duration(milliseconds: 1500000),
    receiveTimeout: const Duration(milliseconds: 5000000000),
    // baseUrl: 'https://pharmacist-app2.000webhostapp.com/api/',
    responseType: ResponseType.json,
    headers: {
      // 'token': token,
      "accept": "application/json",
      'content-Type': 'application/json'
    },
  );
}
