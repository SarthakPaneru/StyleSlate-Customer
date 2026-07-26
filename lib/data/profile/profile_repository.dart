import 'dart:io';

abstract class ProfileRepository {
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> uploadProfileImage(File file);

  Future<String> getProfileImageUrl();
}
