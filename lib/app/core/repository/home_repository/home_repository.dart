import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:first/app/core/model/place_comment_model.dart';
import 'package:first/app/core/model/promo_model.dart';
import 'package:first/app/core/model/user_comment.dart';
import 'package:first/app/core/services/api_result.dart';

import '../../model/category.dart';
import '../../model/place_model.dart';
import '../../model/region_model.dart';
import '../../model/sevices_details_model.dart';
import '../../model/sub_category_model.dart';
import '../../services/error_handler.dart';
import '../../services/failure.dart';
import '../../services/local_storage/client_api.dart';

class HomeRepository {
  var apiData;

  Future<ApiResult<List<CategoryModel>>> getAllCategories() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("allCategoriesrepo");
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/get/all/cat",
        options: Dio.Options(headers: {'auth': true}),
      );
      // log(response.data["categoris"].toString());
      if (response.statusCode == 200) {
        var data = response.data["categoris"] as List;
        List<CategoryModel> allCategory =
            data.map((e) => CategoryModel.fromJson(e)).toList();
        return ApiResult(null, allCategory);
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

  Future<ApiResult<PlaceModel>> getPlaceDetails(String id) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/place/get",
        data: {"id": id},
        options: Dio.Options(headers: {'auth': true}),
      );
      // Map<String,dynamic> mapResponse=response.data["place"];

      // log(mapResponse.toString());

      if (response.statusCode == 200) {
        PlaceModel placeDetails = PlaceModel.fromJson(response.data["place"]);

        print(placeDetails.toString());
        return ApiResult(null, placeDetails);
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

  Future<ApiResult<List<PromoModel>>> getAllPromo() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("Promo...............................");
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/get/promo",
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("Promo${response.data}");
      if (response.statusCode == 200) {
        var data = response.data["promo"] as List;
        List<PromoModel> allPromo =
            data.map((e) => PromoModel.fromJson(e)).toList();
        // log(allPromo.toString());

        return ApiResult(null, allPromo);
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

  Future<ApiResult<List<ServiceDetailsModel>>> getServiceDetails(
      String id) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      log("getServiceDetails...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/place/get/services",
        data: {"placeId": id},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getServiceDetails......${response.data}");

      if (response.statusCode == 200) {
        var data = response.data["services"] as List;
        // log("lddddddddddddddd"+data.toString());
        List<ServiceDetailsModel> listService =
            data.map((e) => ServiceDetailsModel.fromJson(e)).toList();

        // print("serv${listService.toString()}");
        return ApiResult(null, listService);
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

  Future<void> addComment(
      {required String placeId,
      required String content,
      required double rating}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("addComment...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/add/comment",
        data: {"placeId": placeId, "content": content, "rating": rating},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("addComment${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<ApiResult<List<PlaceCommentsModel>>> getAllComments(
      {required String placeId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/get/comment",
        data: {"placeId": placeId},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getAllComments......${response.data}");

      if (response.statusCode == 200) {
        var data = response.data["comments"] as List;
        List<PlaceCommentsModel> listAllComments =
            data.map((e) => PlaceCommentsModel.fromJson(e)).toList();
        return ApiResult(null, listAllComments);
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

  Future<void> updateComment({
    required String commentId,
    required String content,
    required double rating,
  }) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("updateComment...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/update/comment",
        data: {"commentId": commentId, "content": content, "rating": rating},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("updateComment${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<void> deleteComment({required String commentId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("deleteComment...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/destroy/comment",
        data: {
          "commentId": commentId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("deleteComment${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<void> addSavedForPlace({required int placeId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    // log("addSavedForPlacenadabitar  9999999");
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/saved/store",
        data: {
          "placeId": placeId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("addSavedForPlace${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****erro$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<void> deleteSavedForPlace({required int placeId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/saved/unSaved",
        data: {
          "placeId": placeId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("deleteSavedForPlace${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("deleteSavedForPlace****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<void> addSavedForService({required int serviceId}) async {
    Dio.Dio dio = await ClientApi().getClient();

    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/saved/store",
        data: {
          "serviceId": serviceId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("addSavedForPlace${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****error$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<void> deleteSavedForService({required int serviceId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/saved/unSaved",
        data: {
          "serviceId": serviceId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("deleteSavedForPlace${response.data}");
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("deleteSavedForPlace****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<ApiResult<List<PlaceModel>>> getPlacesFromCat(
      {required int catId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("getPlacesFromCat...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/place/get/byCategory",
        data: {"catId": catId},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getPlacesFromCat"+response.data["places"].toString());

      if (response.statusCode == 200) {
        var data = response.data["places"] as List;
        List<PlaceModel> places =
            data.map((e) => PlaceModel.fromJson(e)).toList();
        // log(places[0].id.toString());
        return ApiResult(null, places);
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

  Future<ApiResult<List<UserCommentModel>>> getAllUserComment() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/all/comment",
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("Promo${response.data}");
      if (response.statusCode == 200) {
        var data = response.data["comment"] as List;
        List<UserCommentModel> allUserComment =
            data.map((e) => UserCommentModel.fromJson(e)).toList();
        // log(response.data.toString());
        // log(allUserComment[0].placeName.toString());

        return ApiResult(null, allUserComment);
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

  Future<bool> isSavedPlace({required int placeId}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/saved/is",
        data: {
          "placeId": placeId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("userIsSaved${response.data}");
      bool isSaved = response.data["status"];
      return isSaved;
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<ApiResult<List<PlaceModel>>> getAllSavedPlace() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/saved/all",
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getAllSaved${response.data}");
      if (response.statusCode == 200) {
        var data = response.data["saved"]["places"] as List;
        List<PlaceModel> allSaved =
            data.map((e) => PlaceModel.fromJson(e)).toList();
        // log(response.data.toString());
        // log("...........................getAllSaved...............");

        return ApiResult(null, allSaved);
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

  Future<ApiResult<PlaceModel>> searchMap(
      {required String name}) async {
    Dio.Dio dio = await ClientApi().getClient();
    // log("searchPlaceByName");
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/place/filterByName",
        data: {"name": name},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getAllSaved${response.data}");
      if (response.statusCode == 200) {
        var data = response.data["places"] ;
        log(response.data.toString());
        if(data==null)
          {

            return ApiResult(null, null);

          }
        else
          {
            PlaceModel place =PlaceModel.fromJson(data);

            log("====================searchMap"+place.placeName);

            return ApiResult(null, place);

          }




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

  Future<ApiResult<List<PlaceModel>>> searchPlaceByName(
      {required String word}) async {
    Dio.Dio dio = await ClientApi().getClient();
    // log("searchPlaceByName");
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/searchByPlaceName",
        data: {"word": word},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getAllSaved${response.data}");
      if (response.statusCode == 200) {
        var data = response.data["places"] as List;
        List<PlaceModel> allSaved =
        data.map((e) => PlaceModel.fromJson(e)).toList();
        // log(allSaved.toString());
        // // log(response.data.toString());
        // // log("...........................searchPlaceByName...............");

        return ApiResult(null, allSaved);
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

  Future<ApiResult<List<ServiceDetailsModel>>> getServicesSaved() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/saved/all",
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getServiceDetails......${response.data}");

      if (response.statusCode == 200) {
        var data = response.data["saved"]["services"] as List;
        // log("lddddddddddddddd"+data.toString());
        List<ServiceDetailsModel> listService =
            data.map((e) => ServiceDetailsModel.fromJson(e)).toList();

        // print("services${listService[0].content.toString()}");
        return ApiResult(null, listService);
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

    Future<bool> logOut({
    required String deviceId,
  }) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/auth/logout",
        data: {
          "deviceId": deviceId,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("userIsSaved${response.data}");
      bool isLogOut = response.data["status"];
      return isLogOut;
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<bool> updatePassword({required String newPassword}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try { log("userIsSaved++++++++++++++--------------------");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/auth/update",
        data: {
          "newPassword": newPassword,
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      bool isupdatePassword = response.data["status"];
       log("updatePassword+++++++---------------${response.data["status"]}");
      return isupdatePassword;
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  Future<ApiResult<List<SubCategoryModel>>> getSubCategoryFromCat(
      {required int id}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      // log("getPlacesFromCat...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/get/child/cat",
        data: {"id": id},
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getSubCategoryFromCat"+response.data["data"].toString());

      if (response.statusCode == 200) {
        var data = response.data["data"] as List;
        List<SubCategoryModel> listSubCat =
        data.map((e) => SubCategoryModel.fromJson(e)).toList();
        // log(places[0].id.toString());
        return ApiResult(null, listSubCat);
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

  Future<ApiResult<List<PlaceModel>>> getPlacesFromFilter({required List<int> listSubCat,required List<int> listRegion}) async {
    Dio.Dio dio = await ClientApi().getClient();
    // final fromData =Dio.FormData.fromMap(
    //     {
    //       "category":[1,2]
    //     }
    // );
    try {
      log("getPlacesFromFilter...............................");
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/place/filter",
        data: {
          "category": listSubCat,
          "region":listRegion
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getPlacesFromFilter" + response.data["places"].toString());


      if (response.statusCode == 200) {
        var data = response.data["places"] as List;
        List<PlaceModel> places =
            data.map((e) => PlaceModel.fromJson(e)).toList();
        // log(places[0].id.toString());
        return ApiResult(null, places);
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

  
  Future<ApiResult<int>> getCodeAuthPassword() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/auth/change",
        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getServiceDetails......${response.data}");

      if (response.statusCode == 200) {
        var codeData = response.data["code"];
        log("lddddddddddddddd"+codeData.toString());

        // print("services${listService[0].content.toString()}");
        return ApiResult(null, codeData);
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


  Future<ApiResult<List<PlaceModel>>> getPlacesRating() async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.get(
        "https://nadabitar.com/where/api/user/place/get/max/rating",

        options: Dio.Options(headers: {'auth': true}),
      );
      // log("getPlacesRating" + response.data["place"].toString());


      if (response.statusCode == 200) {
        var data = response.data["place"] as List;
        List<PlaceModel> placesRating =
        data.map((e) => PlaceModel.fromJson(e)).toList();
        return ApiResult(null, placesRating);
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
  Future<bool> updateUser({ required String fullName,
    required int regionId,
    required int streetId,}) async {
    Dio.Dio dio = await ClientApi().getClient();
    try {
      Response response = await dio.post(
        "https://nadabitar.com/where/api/user/update/profile",
        data: {
          "fullName": fullName,
           "regionId": regionId,
                "streetId": streetId
        },
        options: Dio.Options(headers: {'auth': true}),
      );
      log("userIsSaved${response.data}");
      bool isupdateUser = response.data["status"];
      return isupdateUser;
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 400) {
        apiData = e.response!.data;
        log("login****reeor$apiData");
        throw ErrorHandler(apiData.toString());
        // }
      } else {
        throw ErrorHandler("Unknown error");
      }
    } catch (_) {
      throw ErrorHandler("Unknown error");
    }
  }

  // Future<void> updateUser({
  //   required String fullName,
  //   required int regionId,
  //   required int streetId,
  // }) async {
  //   try {
  //     log("get updateUser ");
  //
  //     Response response = await dio
  //         .post("https://nadabitar.com/where/api/user/update/profil", data: {
  //       "fullName": fullName,
  //       "regionId": regionId,
  //       "streetId": streetId
  //     });
  //     log(response.data.toString());
  //   } catch (e) {
  //     throw ErrorHandler(e.toString());
  //   }
  // }
}
