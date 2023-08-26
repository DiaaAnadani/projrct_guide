import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/.env.dart';
import '../model/directions_model.dart';


class DirectionsRepository {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio dio = Dio();

  Future<Directions> getDirection({required LatLng origin ,required LatLng destination}) async {
    final response = await dio.get(
      _baseUrl,
      queryParameters: {
        'key':googleApiKey,
        'origin': '${origin.latitude},${origin.longitude}',
        'destination':'${destination.latitude},${destination.longitude}',
      },
    );

      return Directions.fromMap(response.data);

    // if(response.statusCode==200){}
  }
}
