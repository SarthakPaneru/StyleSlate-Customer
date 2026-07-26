import 'package:hamro_barber_mobile/constants/app_constants.dart';

/// Builds the same protected-image URL the legacy ApiRequests helpers did,
/// as a pure function new repositories can depend on directly.
class ImageUrlBuilder {
  ImageUrlBuilder._();

  static String forUser(int userId) {
    return '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId/get-image';
  }
}
