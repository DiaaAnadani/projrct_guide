import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

import '../../../../core/model/sevices_details_model.dart';
import '../../../../core/services/api_result.dart';

class FavoriteServiceController extends GetxController
{FavoriteServiceController({required this.homeRepository});
HomeRepository homeRepository;


  List<ServiceDetailsModel> listService = [];
  bool isLoadingService=false;
  late List<bool> isFavoriteService=[false, false] ;
    FavoritePlaceWidgetState favoritePlaceWidgetState =
      FavoritePlaceWidgetState.done;

@override
void onInit() {getServicesSaved();}

  Future<void> getServicesSaved() async {
    isLoadingService=false;
     favoritePlaceWidgetState = FavoritePlaceWidgetState.loading;
    update(["iconFavoriteService"]);
    // categoryWidgetState = CategoryWidgetState.loading;
    ApiResult<List<ServiceDetailsModel>> serviceDetailsResponse =
    await homeRepository.getServicesSaved();
   favoritePlaceWidgetState = FavoritePlaceWidgetState.done;
    if (serviceDetailsResponse.data != null) {

      listService = serviceDetailsResponse.data!;
      isLoadingService=true;
      update(["iconFavoriteService"]);

    } else if (serviceDetailsResponse.failure != null) {
      log(serviceDetailsResponse.failure!.message ??
          serviceDetailsResponse.failure!.code.toString());
      isLoadingService=true;
       favoritePlaceWidgetState = FavoritePlaceWidgetState.error;
      update(["iconFavoriteService"]);
   
    } else {
      log('data is Empty');
    }
  }

void changeFavouriteService(int index) {
  listService.remove(listService[index]);
  update(["iconFavoriteService"]);
}

Future<void> deleteSavedForService(
    {required int serviceId, required int index}) async {
  try {
    await homeRepository.deleteSavedForService(
      serviceId: serviceId,
    );
    changeFavouriteService(index);

    BotToast.showText(text: "unSaved successfully");
  } catch (e) {
    log(e.toString());
    BotToast.showText(text: "Something went error");
  }
}

  void goToPlaceServicesView(){
    Get.toNamed("/PlaceServicesView");
  }


}
enum FavoritePlaceWidgetState { empty, error, loading, done }