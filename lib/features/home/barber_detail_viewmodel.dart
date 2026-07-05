import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/home/home_repository.dart';
import 'package:hamro_barber_mobile/features/home/models/barber_detail_dto.dart';
import 'package:hamro_barber_mobile/services/customer_session_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Replaces `Screen/detailScreen.dart`.
class BarberDetailViewModel extends BaseViewModel {
  BarberDetailViewModel(this.barberId);

  final int barberId;

  final _homeRepository = locator<HomeRepository>();
  final _customerSessionService = locator<CustomerSessionService>();
  final _navigationService = locator<NavigationService>();

  BarberDetailDto? barber;
  String imageUrl = '';

  Future<void> init() async {
    await runBusyFuture(_load());
  }

  Future<void> _load() async {
    barber = await _homeRepository.getBarber(barberId);

    // Matches the original `Screen/detailScreen.dart` behavior: it built the
    // image URL from the logged-in customer's own user id rather than the
    // barber's, via `ApiRequests.retrieveImageUrl()`. Preserved as-is here.
    final loggedInUserId = await _customerSessionService.retrieveUserId();
    if (loggedInUserId != null) {
      imageUrl = _homeRepository.imageUrlForUser(int.parse(loggedInUserId));
    }
  }

  void bookService(int serviceId) {
    _navigationService.navigateTo(
      Routes.bookingView,
      arguments: BookingViewArguments(barberId: barberId, serviceId: serviceId),
    );
  }
}
