import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:first/app/core/model/region_model.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../services/api_result.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';
import '../services/local_storage/get_storage_local_db.dart';
import '../services/storage_service.dart';

class AuthenticationRepository {
  final Dio dio;
  final GetStorageLocalDb getStorageLocalDb;
  StoragesService storagesService = StoragesService();

  AuthenticationRepository(
      {required this.dio, required this.getStorageLocalDb});


  var apiData;
  var apiDataRegister;

  Future<User> register({
    required String fullName,
    required String email,
    required String password,
    required String gender,
    required String userType,
    required String deviceId,
    required String regionId,
    required String streetId,
  }) async {
    // Response response;
    try {
      Response response = await dio

          .post("https://nadabitar.com/where/api/auth/register", data: {
        "email": email,
        "fullName": fullName,
        "gender": gender,
        "password": password,
        "userType": userType,
        "regionId": regionId,
        "deviceId": deviceId,
        "streetId": streetId,
      });
      log(response.data.toString());
      getStorageLocalDb.saveToken(response.data["accout"]["token"]);
      // storagesService.setUser(response.data["accout"]);
      return (User.fromJson(response.data["accout"]));
    } on DioException catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiDataRegister = e.response!.data;
        throw ErrorHandler(apiDataRegister.toString());
      } else {
        throw ErrorHandler("koko error");
      }
    } catch (e) {
      log("============================="+e.toString());
      throw ErrorHandler("Unknown error");
    }
  }

  Future<User> login({required String email, required String password}) async {
    try {
      Response response =
      await dio.post("https://nadabitar.com/where/api/auth/login", data: {
        "email": email,
        "password": password,
      });
      getStorageLocalDb.saveToken(response.data["token"]);
      return (User.fromJson(response.data["account"]));
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        throw ErrorHandler(apiData.toString());

      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<ApiResult<List<Region>>> getAllRegion() async {
    try {
      Response response = await dio.get(
        "https://nadabitar.com/where/api/get/all/region",
      );

      // log("regionresponse+++++++++++++++++"+response.data.toString());
      if (response.statusCode == 200) {
        var data = response.data["region"] as List;
        List<Region> allRegion = data.map((e) => Region.fromJson(e)).toList();


        // log("regionrespname+"+allRegion[0].name);
        return ApiResult(null, allRegion);
      } else {
        return ApiResult(Failure(response.statusCode, ''), null);
      }
    } on SocketException {
      return ApiResult(Failure(0, 'Check your Internet connection'), null);
    } on FormatException {
      return ApiResult(Failure(0, 'Problem reciving data'), null);
    } on DioError catch (error) {
      return ApiResult(Failure(0, error.toString()), null);
    }
  }

  Future<ApiResult<List<Region>>> getAllStreetForRegionSelect(
      {required int id}) async {
    try {
      Response response =
      await dio.post('https://nadabitar.com/where/api/get/street', data: {
        "id": id,
      });
      // log(response.data["street"].toString());
      if (response.statusCode == 200) {
        var data = response.data["data"] as List;
        List<Region> allRegion = data.map((e) => Region.fromJson(e)).toList();

        // log(allRegion[0].name);
        return ApiResult(null, allRegion);
      } else {
        return ApiResult(Failure(response.statusCode, ''), null);
      }
    } on SocketException {
      return ApiResult(Failure(0, 'Check your Internet connection'), null);
    } on FormatException {
      return ApiResult(Failure(0, 'Problem reciving data'), null);
    } on DioException catch (error) {
      return ApiResult(Failure(0, error.toString()), null);
    }
  }




}
