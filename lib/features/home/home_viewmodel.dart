import 'package:geolocator/geolocator.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/home/home_repository.dart';
import 'package:hamro_barber_mobile/features/home/models/barber_summary_dto.dart';
import 'package:hamro_barber_mobile/services/customer_session_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Replaces `modules/screens/user_home.dart` merged with
/// `widgets/barberSelection.dart` (the barber list it rendered inline).
class HomeViewModel extends BaseViewModel {
  final _customerSessionService = locator<CustomerSessionService>();
  final _homeRepository = locator<HomeRepository>();
  final _navigationService = locator<NavigationService>();

  static const categories = ['Haircut', 'Hair Style', 'Beard', 'Treatment', 'Beauty Saloon'];

  String firstName = '';
  double latitude = 0;
  double longitude = 0;
  List<BarberSummaryDto> barbers = [];
  bool isLoadingBarbers = true;

  Future<void> init() async {
    firstName = await _customerSessionService.retrieveFirstName() ?? '';
    await _loadLocation();
    await _loadBarbers();
  }

  Future<void> _loadLocation() async {
    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 0;
    longitude = prefs.getDouble('longitude') ?? 0;

    try {
      await Geolocator.requestPermission();
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      await prefs.setDouble('latitude', latitude);
      await prefs.setDouble('longitude', longitude);
    } catch (_) {
      // Keep the cached fallback location if a live fix isn't available.
    }
    rebuildUi();
  }

  Future<void> _loadBarbers() async {
    try {
      barbers = await _homeRepository.getNearestBarbers(latitude, longitude);
    } catch (_) {
      barbers = [];
    }
    isLoadingBarbers = false;
    rebuildUi();
  }

  String imageUrlFor(BarberSummaryDto barber) {
    final userId = barber.user?.id;
    return userId != null ? _homeRepository.imageUrlForUser(userId) : '';
  }

  String nameFor(BarberSummaryDto barber) =>
      '${barber.user?.firstName ?? ''} ${barber.user?.lastName ?? ''}'.trim();

  void openBarberDetail(int barberId) {
    _navigationService.navigateTo(Routes.barberDetailView,
        arguments: BarberDetailViewArguments(barberId: barberId));
  }
}
