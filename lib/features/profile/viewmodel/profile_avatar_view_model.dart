import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository.dart';

class ProfileAvatarViewModel extends ChangeNotifier {
  ProfileAvatarViewModel(this._repository);

  final ProfileRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;
  String imageUrl = '';

  Future<void> loadImageUrl() async {
    imageUrl = await _repository.getProfileImageUrl();
    notifyListeners();
  }

  Future<bool> uploadImage(File file) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.uploadProfileImage(file);
      status = ViewStatus.success;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
  }
}
