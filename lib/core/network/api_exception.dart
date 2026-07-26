import 'package:dio/dio.dart';

sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  factory AppException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const AppTimeoutException(
            'The request timed out. Please try again.');
      case DioExceptionType.connectionError:
        return const AppNetworkException(
            'Could not reach the server. Check your internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final serverMessage = _extractMessage(e.response?.data);
        if (statusCode == 401 || statusCode == 403) {
          return AppUnauthorizedException(
              serverMessage ?? 'Session expired. Please log in again.');
        }
        if (statusCode >= 400 && statusCode < 500) {
          return AppBadRequestException(
              statusCode, serverMessage ?? 'Invalid request.');
        }
        return AppServerException(
            serverMessage ?? 'Something went wrong on the server.');
      case DioExceptionType.cancel:
        return const AppUnknownException('The request was cancelled.');
      case DioExceptionType.badCertificate:
        return const AppNetworkException('A secure connection could not be established.');
      case DioExceptionType.unknown:
        return const AppUnknownException(
            'Something went wrong. Please try again.');
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }
    return null;
  }
}

final class AppNetworkException extends AppException {
  const AppNetworkException(super.message);
}

final class AppTimeoutException extends AppException {
  const AppTimeoutException(super.message);
}

final class AppBadRequestException extends AppException {
  const AppBadRequestException(this.statusCode, super.message);

  final int statusCode;
}

final class AppUnauthorizedException extends AppException {
  const AppUnauthorizedException(super.message);
}

final class AppServerException extends AppException {
  const AppServerException(super.message);
}

final class AppParseException extends AppException {
  const AppParseException(super.message);
}

final class AppUnknownException extends AppException {
  const AppUnknownException(super.message);
}
