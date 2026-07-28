import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/core/utils/image_url_builder.dart';
import 'package:hamro_barber_mobile/data/auth/models/logged_in_user_response.dart';
import 'models/update_password_request.dart';
import 'profile_api.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._profileApi);

  final ProfileApi _profileApi;

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final email = await Customer().retrieveCustomerEmail();
      await _profileApi.updatePassword(
        UpdatePasswordRequest(
          email: email ?? '',
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmNewPassword: confirmPassword,
        ),
      );
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<void> uploadProfileImage(File file) async {
    try {
      await _profileApi.uploadImage(file);
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<String> getProfileImageUrl() async {
    final userId = await Customer().retrieveUserId();
    return ImageUrlBuilder.forUser(int.parse(userId ?? '0'));
  }

  @override
  Future<UserResponse> getAccountDetails() async {
    try {
      final response = await _profileApi.getLoggedInUser();
      // Keep the locally cached copy (used elsewhere in the app) in sync
      // with what the backend actually has, same as login() does.
      await Customer().storeCustomerDetails(response.toJson());
      return response.user;
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }
}
