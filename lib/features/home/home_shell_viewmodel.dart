import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/services/customer_session_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

/// Replaces `modules/screens/homepage.dart` (`HomePage`), the bottom-nav
/// shell. The Account tab and the chat FAB still point at the original,
/// not-yet-migrated `ProfileScreen`/`ChatPage` widgets — Profile and Socket
/// chat are separate migration passes.
class HomeShellViewModel extends BaseViewModel {
  final _customerSessionService = locator<CustomerSessionService>();

  int selectedIndex = 0;
  int? customerId;
  double latitude = 0;
  double longitude = 0;

  Future<void> init() async {
    customerId = await _customerSessionService.retrieveCustomerId();

    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 0;
    longitude = prefs.getDouble('longitude') ?? 0;
    rebuildUi();
  }

  void selectTab(int index) {
    selectedIndex = index;
    rebuildUi();
  }
}
