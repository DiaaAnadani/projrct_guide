import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/model/directions_model.dart';
import '../../../core/model/place_model.dart';
import '../../../core/repository/directions_repository.dart';
import '../../../core/services/api_result.dart';
import '../../../core/services/location_service.dart';
import '../../../core/widgets/custom_button_error.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/new_custom_search.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver {
  HomeRepository homeRepository = Get.put(HomeRepository());
  TextEditingController controller = TextEditingController();
  List<PlaceModel> listSearchPlace = [];
  SearchPlaceWidgetState? searchPlaceWidgetState;
  MapWidgetState mapWidgetState = MapWidgetState.loading;
  PlaceModel? place;

  // bool isKeyboardVisible = false;
  bool isVisible = false;
  String? selectedItem;

  // List<String> items = [];
  LocationData? locationData;
  double latOriginal = 0;
  double longOriginal = 0;

  double latDestination = 0;
  double longDestination = 0;

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  @override
  void dispose() {
    controller.dispose();
    _googleMapController?.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    getLocationForMap();
    searchMap(name: "Jeffrey Bailey");
    WidgetsBinding.instance?.addObserver(this);

    super.initState();
  }

  @override
  void didChangeMetrics() {
    final bool isKeyboardVisible =
        WidgetsBinding.instance?.window.viewInsets.bottom != 0;
    if (isKeyboardVisible == true) {
      log("isKeyboardVisible open");
    } else {
      setState(() {
        isVisible = false;
      });
      FocusScope.of(context).unfocus();
      log("isKeyboardVisible close");
    }
  }

  getLocationForMap() async {
    setState(() {
      mapWidgetState = MapWidgetState.loading;
    });
    locationData = await LocationService().getLocation();
    if (locationData != null) {
      setState(() {
        mapWidgetState = MapWidgetState.accept;
        latOriginal = locationData!.latitude!;
        longOriginal = locationData!.longitude!;

        _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow:
                const InfoWindow(title: 'Origin', snippet: "hi!! تقييمه"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta),
            position: LatLng(latOriginal, longOriginal));
      });
    } else {
      setState(() {
        mapWidgetState = MapWidgetState.noAccept;
      });
    }

    log("=============================+your location${locationData?.latitude} ${locationData?.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(latOriginal!, longOriginal!), zoom: 15, tilt: 50.0);

    switch (mapWidgetState) {
      case MapWidgetState.loading:
        return Container(
            color: Colors.white,
            child: const Center(child: CircularWidget(color: colorBlack)));
        break;
      case MapWidgetState.noAccept:
        return SafeArea(
            child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.locationPinLock,
                    color: Colors.blue.shade800,
                    size: 35,
                  ),
                ),
                Text(
                  "الرجاء تشغيل خدمة الموقع لفتح الخريطة".tr,
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 5.5.h,
                  width: 20.w,
                  child: ElevatedButton(
                      onPressed: () {
                        getLocationForMap();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          //  MaterialStateProperty.all(colorMainLight),
                              MaterialStateProperty.all(Theme.of(context).primaryColor),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ))),
                      child: Text("تشغيل".tr)),
                )
              ],
            ),
          ),
        ));
        break;

      case MapWidgetState.accept:
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor:  Theme.of(context).primaryColor,
            // backgroundColor: colorMainLight,
            centerTitle: false,
            title: const Text(
              'الخريطة',
              style: TextStyle(
                  color: colorWhite, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            actions: [
              if (_origin != null)
                TextButton(
                    onPressed: () => _googleMapController!.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: _origin!.position, zoom: 15, tilt: 50.0))),
                    style: TextButton.styleFrom(
                        primary: dark,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w600)),
                    child: Text(
                      "ORIGIN".tr,
                      style: const TextStyle(fontSize: 19),
                    )),
              if (_destination != null)
                TextButton(
                    onPressed: () => _googleMapController!.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: _destination!.position,
                            zoom: 15,
                            tilt: 50.0))),
                    style: TextButton.styleFrom(
                        primary: oooooo,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w600)),
                    child:
                        Text("DEST".tr, style: const TextStyle(fontSize: 19))),
              // TextButton(
              //     onPressed: () async => await getDestination(),
              //     style: TextButton.styleFrom(
              //         primary: Colors.blue,
              //         textStyle:
              //             const TextStyle(fontWeight: FontWeight.w600)),
              //     child: const Text("getDestination")),
            ],
          ),
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              GoogleMap(
                initialCameraPosition: initialCameraPosition,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) =>
                    _googleMapController = controller,
                markers: {
                  if (_origin != null) _origin!,
                  if (_destination != null) _destination!,
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: Colors.red,
                        width: 5,
                        points: _info!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList()),
                },
                // onLongPress: _addMarker,
              ),
              // TextField(
              //   onChanged: (value) {
              //     resultSearch();
              //
              //     log("==============================yes===============");
              //     log("=============$value=====");
              //   },
              //   controller: controller,
              //   decoration: const InputDecoration(
              //       labelText: "Search",
              //       border: OutlineInputBorder(
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(15.0)))),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 7.h,
                    width: double.infinity,
                    child: CustomSearchTextField(
                      onChanged: (value) {
                        searchPlace(value: value, isOnSubmitted: false);
                      },
                      onSubmitted: (value) {
                        searchPlace(value: value, isOnSubmitted: true);
                      },
                      controller: controller,
                      onTap: () {
                        if (controller.text.isNotEmpty) {
                          searchPlaceByName(word: controller.text);
                        }
                        log("===================onTap==========================");
                      },
                    )),
                // SizedBox(
                //   width: 80.w,
                //   height: 7.h,
                //   child: CustomTextField(
                //     fillColor: colorWhite,
                //     cursorColor: colorMain,
                //     colorText: Colors.black,
                //     onTap: () {
                //       if (controller.text.isNotEmpty) {
                //         searchPlaceByName(word: controller.text);
                //       }
                //       log("===================onTap==========================");
                //     },
                //     onChanged: (value) {
                //       if (value.isNotEmpty) {
                //         searchPlaceByName(word: value);
                //       } else {
                //         setState(() {
                //           isVisible = false;
                //         });
                //       }
                //
                //       log("=============$value=====..");
                //     },
                //     suffixIcon: controller.text.isNotEmpty
                //         ? InkWell(
                //         onTap: () {
                //           setState(() {
                //             controller.clear();
                //             isVisible = false;
                //           });
                //         },
                //         child: const Icon(
                //           color: colorMain,
                //           Icons.clear,
                //           size: 22,
                //         ))
                //         : const SizedBox(),
                //     textAlign: TextAlign.start,
                //     hintText: 'Search Place ...'.tr,
                //     controller: controller,
                //     colorBorder: Colors.black38,
                //     colorHint: colorBlackHint,
                //     colorIcon: colorBlackHint,
                //   ),
                // ),
              ),
              if (isVisible == true)
                Positioned(
                  right: 55,
                  top: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorWhite,
                    ),
                    width: 61.w,
                    height: 35.h,
                    child: searchPlaceWidgetState ==
                            SearchPlaceWidgetState.loading
                        ? const CircularWidget(
                            color: colorBlack,
                          )
                        : searchPlaceWidgetState == SearchPlaceWidgetState.empty
                            ? const Center(
                                child: Text(
                                "Not Found",
                                style: TextStyle(fontSize: 20),
                              ))
                            : searchPlaceWidgetState ==
                                    SearchPlaceWidgetState.error
                                ? CustomButtonError(
                                    text: "Try agine".tr,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listSearchPlace.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Ink(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedItem =
                                                  listSearchPlace[index]
                                                      .placeName;
                                              controller.text = selectedItem!;
                                              isVisible = false;
                                              FocusScope.of(context).unfocus();
                                              getDestination(
                                                  place:
                                                      listSearchPlace[index]);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Text(listSearchPlace[index]
                                                .placeName),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                  ),
                ),

              if (_info != null)
                Positioned(
                  top: 70.h,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ],
                    ),
                    child: Text(
                      '${_info!.totalDuration} , ${_info!.totalDistance}',
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () => _googleMapController!.animateCamera(_info != null
                ? CameraUpdate.newLatLngBounds(_info!.bounds, 100)
                : CameraUpdate.newCameraPosition(initialCameraPosition)),
            child: const Icon(Icons.center_focus_strong),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
        break;
    }
  }

  Future<void> searchPlace(
      {required String value, required bool isOnSubmitted}) async {
    if (value.isNum || value.isEmpty || value.trim() == '' || isSymbol(value)) {
      setState(() {
        isVisible = false;
      });
    } else {
      log("============$value===================");
      isOnSubmitted
          ? searchMap(name: value)
          : await searchPlaceByName(word: value);
    }
  }

  bool isSymbol(String character) {
    // التحقق مما إذا كان الحرف رمز لوحة المفاتيح
    RegExp regex = RegExp(r'[!@#\$&*~]');
    return regex.hasMatch(character);
  }

  // resultSearch(BuildContext context){
  //
  //
  //   showDialog(context: context, builder: (context){
  //
  //     return AlertDialog(
  //
  //
  //
  //         // title: searchBar,
  //         content: StatefulBuilder(
  //           builder: (context, setState) => Container(
  //             width: 200,
  //             height: 200,
  //
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: items == null? 0: items.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return Ink(
  //                   child: InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         selectedItem = items[index];
  //                         controller.text=selectedItem!;
  //                         Navigator.pop(context);
  //                       });
  //                     },
  //                     child: ListTile(
  //                       title: Text(items[index]),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         )
  //     );
  //
  //   });
  //
  // }

  Future<void> searchPlaceByName({required String word}) async {
    log("================searchPlaceByName==============");
    listSearchPlace.clear();
    // log(listSearchPlace.toString());

    setState(() {
      isVisible = true;
      searchPlaceWidgetState = SearchPlaceWidgetState.loading;
    });

    ApiResult<List<PlaceModel>> allPlaceResponse =
        await homeRepository.searchPlaceByName(word: word);

    if (allPlaceResponse.data != null) {
      listSearchPlace = allPlaceResponse.data!;
      // log("listSearchPlace" + listSearchPlace[0].placeName.toString());
      log(listSearchPlace.toString());
      if (listSearchPlace.isEmpty) {
        setState(() {
          searchPlaceWidgetState = SearchPlaceWidgetState.empty;
        });
      } else {
        setState(() {
          searchPlaceWidgetState = SearchPlaceWidgetState.done;
        });
        BotToast.showText(text: "SearchPlaceController successfully");
      }
    } else if (allPlaceResponse.failure != null) {
      log(allPlaceResponse.failure!.message ??
          allPlaceResponse.failure!.code.toString());

      setState(() {
        searchPlaceWidgetState = SearchPlaceWidgetState.error;
      });
    } else {
      log('data is Empty');
    }
  }

  Future<void> searchMap({required String name}) async {
    log("================searchPlaceByName==============");
    // listSearchPlace.clear();

    ApiResult<PlaceModel> PlaceResponse =
        await homeRepository.searchMap(name: name);

    if (PlaceResponse.data != null) {
      place = PlaceResponse.data!;
      log("searchMap controller" + place!.placeName.toString());

      getDestination(place: place);

      // BotToast.showText(text: "SearchPlaceController successfully");
    } else if (PlaceResponse.failure != null) {
      log(PlaceResponse.failure!.message ??
          PlaceResponse.failure!.code.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.text + " غير موجود",
            style: TextStyle(color: colorOrangeAccent),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
      log('data is Empty');
    }
  }

  // resultSearch() {
  //   log("================resultSearch==============");
  //   items.clear();
  //   log(items.toString());
  //   items = ["hhh", "mmm", "lll", "uuu", "ppp"];
  //   log(items.toString());
  //   setState(() {
  //     if (items != null) {
  //       isVisible = true;
  //     }
  //   });
  // }

  // void _addMarker(LatLng pos) async {
  //   if (_origin == null || (_origin != null && _destination != null)) {
  //     setState(() {
  //       _origin = Marker(
  //           markerId: const MarkerId('origin'),
  //           infoWindow: const InfoWindow(title: 'Origin'),
  //           icon: BitmapDescriptor.defaultMarkerWithHue(
  //               BitmapDescriptor.hueGreen),
  //           position: pos);
  //       _destination = null;
  //       _info = null;
  //     });
  //   } else {
  //     setState(() {
  //       _destination = Marker(
  //           markerId: const MarkerId('destination'),
  //           infoWindow: const InfoWindow(title: 'Destination'),
  //           icon:
  //               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //           position: pos);
  //     });
  //     final directions = await DirectionsRepository()
  //         .getDirection(origin: _origin!.position, destenation: pos);
  //     setState(() {
  //       _info = directions;
  //     });
  //   }
  // }

  Future<void> getDestination({required PlaceModel? place}) async {
    log("=======================kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    setState(() {
      _info = null;
      _destination = null;
    });

    latDestination = place!.latitud;
    longDestination = place.longitude;

    setState(() {
      _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: InfoWindow(title: place.placeName),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: LatLng(latDestination, longDestination));
    });

    final directions = await DirectionsRepository().getDirection(
        origin: _origin!.position, destination: _destination!.position);
    setState(() {
      _info = directions;
    });
  }
}

enum SearchPlaceWidgetState { empty, error, done, loading }

enum MapWidgetState { accept, noAccept, loading }
