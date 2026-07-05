import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/features/auth/auth_repository.dart';
import 'package:hamro_barber_mobile/features/home/home_repository.dart';
import 'package:hamro_barber_mobile/network/api_client.dart';
import 'package:hamro_barber_mobile/network/dio_client.dart';
import 'package:hamro_barber_mobile/services/customer_session_service.dart';
import 'package:hamro_barber_mobile/services/token_service.dart';

/// Registers the dependencies that need real constructor arguments
/// (Dio's baseUrl/interceptors, Retrofit's Dio instance, the repository's
/// collaborators) directly against the generated `locator`. `@StackedApp`'s
/// declarative `dependencies` list only auto-wires types it can construct
/// from other registered types with no extra configuration, so services that
/// need setup logic are registered here instead. Call after `setupLocator()`.
void registerAppDependencies() {
  locator.registerLazySingleton<TokenService>(() => TokenService());
  locator.registerLazySingleton<CustomerSessionService>(() => CustomerSessionService());
  locator.registerLazySingleton<Dio>(() => DioClient(locator<TokenService>()).dio);
  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<Dio>()));
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator<ApiClient>(),
      locator<TokenService>(),
      locator<CustomerSessionService>(),
    ),
  );
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(locator<ApiClient>()));
}
