import 'package:clean_architecture/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          failure = DataSource.CONNECT_TIMEOUT.getFailure();
          break;
        case DioExceptionType.sendTimeout:
          failure = DataSource.SEND_TIMEOUT.getFailure();
          break;
        case DioExceptionType.receiveTimeout:
          failure = DataSource.RECEIVE_TIMEOUT.getFailure();
          break;
        case DioExceptionType.cancel:
          failure = DataSource.CANCEL.getFailure();
          break;
        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case ResponseCode.BAD_REQUEST:
              failure = DataSource.BAD_REQUEST.getFailure();
              break;
            case ResponseCode.FORBIDDEN:
              failure = DataSource.FORBIDDEN.getFailure();
              break;
            case ResponseCode.UNAUTHORISED:
              failure = DataSource.UNAUTHORISED.getFailure();
              break;
            case ResponseCode.NOT_FOUND:
              failure = DataSource.NOT_FOUND.getFailure();
              break;
            case ResponseCode.INTERNAL_SERVER_ERROR:
              failure = DataSource.INTERNAL_SERVER_ERROR.getFailure();
              break;
            default:
              failure = DataSource.DEFAULT.getFailure();
          }
          break;
        case DioExceptionType.unknown:
        default:
          failure = DataSource.DEFAULT.getFailure();
      }
    } else {
      // Handle unknown errors
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
            ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  /// API status codes
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int FORBIDDEN = 403; // failure, api rejected the request
  static const int UNAUTHORISED = 401; // failure user is not authorised
  static const int NOT_FOUND = 404; // failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash happened in server side

  /// local status codes
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  /// API status messages
  static const String SUCCESS = "success"; // success with data
  static const String NO_CONTENT = "success with no content"; // success with no content
  static const String BAD_REQUEST =
      "Bad request, try again later"; // failure, api rejected the request
  static const String FORBIDDEN =
      "Forbidden request, try again later"; // failure, api rejected the request
  static const String UNAUTHORISED =
      "User unauthorised, try again later "; // failure user is not authorised
  static const String NOT_FOUND =
      "URL is not found, try again later"; // failure, api url is not correct and not found
  static const String INTERNAL_SERVER_ERROR =
      "Something went wrong, try again later "; // failure, crash happened on server side

  /// local status messages
  static const String DEFAULT = "Something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "Time out error, try again later";
  static const String CANCEL = "Request was cancelled, try again later ";
  static const String RECEIVE_TIMEOUT = "Time out error, try again later ";
  static const String SEND_TIMEOUT = "Time out error, try again later ";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your internet connection";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
