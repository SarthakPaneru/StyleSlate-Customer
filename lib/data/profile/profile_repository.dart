import 'dart:io';

import 'package:hamro_barber_mobile/data/auth/models/logged_in_user_response.dart';

abstract class ProfileRepository {
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> uploadProfileImage(File file);

  Future<String> getProfileImageUrl();

  /// Fetches the signed-in customer's own details fresh from the backend,
  /// rather than relying on the locally cached copy stored at login.
  Future<UserResponse> getAccountDetails();
}
