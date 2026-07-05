import 'package:hamro_barber_mobile/core/walk_through/splash_screen.dart';
import 'package:hamro_barber_mobile/features/auth/forgot_password_update_view.dart';
import 'package:hamro_barber_mobile/features/auth/forgot_password_view.dart';
import 'package:hamro_barber_mobile/features/auth/login_view.dart';
import 'package:hamro_barber_mobile/features/auth/register_view.dart';
import 'package:hamro_barber_mobile/features/home/barber_detail_view.dart';
import 'package:hamro_barber_mobile/features/home/booking_view.dart';
import 'package:hamro_barber_mobile/features/home/home_shell_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

/// `@StackedApp` config: generates `app.router.dart` (Routes + StackedRouter,
/// replacing every hand-rolled `Navigator.push(MaterialPageRoute(...))` call
/// in the Auth flow) and `app.locator.dart` (the `get_it` locator + this
/// service list). Feature-owned dependencies (TokenService, ApiClient,
/// AuthRepository, etc.) are registered separately in `app_dependencies.dart`
/// — see the comment there for why.
@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: ForgotPasswordUpdateView),
    MaterialRoute(page: HomeShellView),
    MaterialRoute(page: BarberDetailView),
    MaterialRoute(page: BookingView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
  ],
)
class App {}
