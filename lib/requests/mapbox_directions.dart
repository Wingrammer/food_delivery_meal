// // ignore_for_file: deprecated_member_use

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:location/location.dart';

// import '../helpers/dio_exceptions.dart';

// String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
// String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
// String navType = 'driving';

// Dio _dio = Dio();

// Future getCyclingRouteUsingMapbox(
//     LocationData source, LocationData destination) async {
//   String url =
//       '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
//   try {
//     _dio.options.contentType = Headers.jsonContentType;
//     final responseData = await _dio.get(url);
//     return responseData.data;
//   } catch (e) {
//     final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
//     debugPrint(errorMessage);
//   }
// }
