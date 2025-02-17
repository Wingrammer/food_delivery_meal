import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  // ignore: deprecated_member_use
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      // ignore: deprecated_member_use
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      // ignore: deprecated_member_use
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      // ignore: deprecated_member_use
      case DioErrorType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      // ignore: deprecated_member_use
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      // ignore: deprecated_member_use
      case DioErrorType.badResponse:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      // ignore: deprecated_member_use
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  late String message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
