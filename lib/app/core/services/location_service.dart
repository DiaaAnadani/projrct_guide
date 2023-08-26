import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService{
  // Future<LocationData?> getLocation() async {
  //   Location location = Location();
  //   location.changeSettings(distanceFilter: 50,interval: 500);
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;
  //
  //   serviceEnabled = await location.serviceEnabled();
  //
  //   if (serviceEnabled) {
  //     permissionGranted = await location.hasPermission();
  //
  //     if (permissionGranted == PermissionStatus.granted) {
  //       locationData = await location.getLocation();
  //       // BotToast.showText(
  //       //     text: locationData.altitude.toString() +
  //       //         locationData.longitude.toString());
  //
  //       log("=============================+your location${locationData.latitude} ${locationData.longitude}");
  //
  //       // location.onLocationChanged.listen((LocationData currentLocation) {
  //       //   log("yourlisten location${currentLocation.latitude} ${currentLocation.longitude}");
  //       // });
  //       return locationData;
  //     } else {
  //       permissionGranted = await location.requestPermission();
  //
  //       if (permissionGranted == PermissionStatus.granted) {
  //         locationData = await location.getLocation();
  //
  //         log('===========================+user allowed after requestPermission ');
  //         return locationData;
  //       } else {
  //         return null;
  //
  //         // SystemNavigator.pop();
  //       }
  //     }
  //   } else {
  //     serviceEnabled = await location.requestService();
  //
  //     if (serviceEnabled) {
  //       permissionGranted = await location.hasPermission();
  //
  //       if (permissionGranted == PermissionStatus.granted) {
  //         locationData = await location.getLocation();
  //
  //         log('==========================================+user allowed before');
  //         return locationData;
  //       } else {
  //         permissionGranted = await location.requestPermission();
  //
  //         if (permissionGranted == PermissionStatus.granted) {
  //           locationData = await location.getLocation();
  //
  //
  //
  //           print('================================user allowed koko');
  //           return locationData;
  //         } else {
  //           return null;
  //           // SystemNavigator.pop();
  //         }
  //       }
  //     } else {
  //       return null;
  //       // SystemNavigator.pop();
  //     }
  //   }
  // }

  Future<LocationData?> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      await location.requestService();
      serviceEnabled = await location.serviceEnabled();
    }

    if (!serviceEnabled) {
      log("==========================lllll");
      return null;
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted && permissionGranted != PermissionStatus.grantedLimited) {
     log("==================soso");
      return null;
    }
    locationData = await location.getLocation();
    log("================koko");
    return locationData;
  }


}
