import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/auth/models/logged_in_user_response.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository.dart';

/// Single shared source of truth for the signed-in user's own profile
/// (name/email/phone), provided once at the app root. Screens that need it
/// (home greeting, My Account, ...) watch this instead of each
/// independently calling GET /customer/get-logged-in-user.
class CurrentUserState extends ChangeNotifier {
  CurrentUserState(this._repository);

  final ProfileRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;
  UserResponse? user;

  Future<void>? _inFlight;

  /// Loads the user if it hasn't been loaded yet. Safe to call from every
  /// screen that needs it on mount -- a request already in flight or a
  /// user already loaded is reused rather than firing a duplicate call.
  Future<void> ensureLoaded() {
    if (user != null) return Future.value();
    return _inFlight ??= _load();
  }

  /// Forces a fresh fetch, e.g. after the user edits their own profile.
  Future<void> refresh() => _inFlight ??= _load();

  Future<void> _load() async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      user = await _repository.getAccountDetails();
      status = ViewStatus.success;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
    } finally {
      _inFlight = null;
      notifyListeners();
    }
  }

  /// Resets state on logout so the next session never briefly shows the
  /// previous user's cached name/email.
  void clear() {
    user = null;
    status = ViewStatus.idle;
    errorMessage = null;
    _inFlight = null;
    notifyListeners();
  }
}
