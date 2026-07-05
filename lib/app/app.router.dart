// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/walk_through/splash_screen.dart'
    as _i2;
import 'package:hamro_barber_mobile/features/auth/forgot_password_update_view.dart'
    as _i6;
import 'package:hamro_barber_mobile/features/auth/forgot_password_view.dart'
    as _i5;
import 'package:hamro_barber_mobile/features/auth/login_view.dart' as _i3;
import 'package:hamro_barber_mobile/features/auth/register_view.dart' as _i4;
import 'package:hamro_barber_mobile/features/home/barber_detail_view.dart'
    as _i8;
import 'package:hamro_barber_mobile/features/home/booking_view.dart' as _i9;
import 'package:hamro_barber_mobile/features/home/home_shell_view.dart' as _i7;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const splashScreen = '/';

  static const loginView = '/login-view';

  static const registerView = '/register-view';

  static const forgotPasswordView = '/forgot-password-view';

  static const forgotPasswordUpdateView = '/forgot-password-update-view';

  static const homeShellView = '/home-shell-view';

  static const barberDetailView = '/barber-detail-view';

  static const bookingView = '/booking-view';

  static const all = <String>{
    splashScreen,
    loginView,
    registerView,
    forgotPasswordView,
    forgotPasswordUpdateView,
    homeShellView,
    barberDetailView,
    bookingView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.splashScreen, page: _i2.SplashScreen),
    _i1.RouteDef(Routes.loginView, page: _i3.LoginView),
    _i1.RouteDef(Routes.registerView, page: _i4.RegisterView),
    _i1.RouteDef(Routes.forgotPasswordView, page: _i5.ForgotPasswordView),
    _i1.RouteDef(
      Routes.forgotPasswordUpdateView,
      page: _i6.ForgotPasswordUpdateView,
    ),
    _i1.RouteDef(Routes.homeShellView, page: _i7.HomeShellView),
    _i1.RouteDef(Routes.barberDetailView, page: _i8.BarberDetailView),
    _i1.RouteDef(Routes.bookingView, page: _i9.BookingView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreen: (data) {
      final args = data.getArgs<SplashScreenArguments>(
        orElse: () => const SplashScreenArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashScreen(key: args.key),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(key: args.key),
        settings: data,
      );
    },
    _i4.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i5.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i6.ForgotPasswordUpdateView: (data) {
      final args = data.getArgs<ForgotPasswordUpdateViewArguments>(
        orElse: () => const ForgotPasswordUpdateViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.ForgotPasswordUpdateView(key: args.key),
        settings: data,
      );
    },
    _i7.HomeShellView: (data) {
      final args = data.getArgs<HomeShellViewArguments>(
        orElse: () => const HomeShellViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.HomeShellView(key: args.key),
        settings: data,
      );
    },
    _i8.BarberDetailView: (data) {
      final args = data.getArgs<BarberDetailViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.BarberDetailView(key: args.key, barberId: args.barberId),
        settings: data,
      );
    },
    _i9.BookingView: (data) {
      final args = data.getArgs<BookingViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.BookingView(
          key: args.key,
          barberId: args.barberId,
          serviceId: args.serviceId,
        ),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class SplashScreenArguments {
  const SplashScreenArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SplashScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RegisterViewArguments {
  const RegisterViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RegisterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForgotPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ForgotPasswordUpdateViewArguments {
  const ForgotPasswordUpdateViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForgotPasswordUpdateViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class HomeShellViewArguments {
  const HomeShellViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeShellViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BarberDetailViewArguments {
  const BarberDetailViewArguments({this.key, required this.barberId});

  final _i10.Key? key;

  final int barberId;

  @override
  String toString() {
    return '{"key": "$key", "barberId": "$barberId"}';
  }

  @override
  bool operator ==(covariant BarberDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.barberId == barberId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ barberId.hashCode;
  }
}

class BookingViewArguments {
  const BookingViewArguments({
    this.key,
    required this.barberId,
    required this.serviceId,
  });

  final _i10.Key? key;

  final int barberId;

  final int serviceId;

  @override
  String toString() {
    return '{"key": "$key", "barberId": "$barberId", "serviceId": "$serviceId"}';
  }

  @override
  bool operator ==(covariant BookingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.barberId == barberId &&
        other.serviceId == serviceId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ barberId.hashCode ^ serviceId.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToSplashScreen({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.splashScreen,
      arguments: SplashScreenArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLoginView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRegisterView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.registerView,
      arguments: RegisterViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToForgotPasswordView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.forgotPasswordView,
      arguments: ForgotPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToForgotPasswordUpdateView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.forgotPasswordUpdateView,
      arguments: ForgotPasswordUpdateViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToHomeShellView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.homeShellView,
      arguments: HomeShellViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBarberDetailView({
    _i10.Key? key,
    required int barberId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.barberDetailView,
      arguments: BarberDetailViewArguments(key: key, barberId: barberId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBookingView({
    _i10.Key? key,
    required int barberId,
    required int serviceId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bookingView,
      arguments: BookingViewArguments(
        key: key,
        barberId: barberId,
        serviceId: serviceId,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSplashScreen({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.splashScreen,
      arguments: SplashScreenArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLoginView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRegisterView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.registerView,
      arguments: RegisterViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithForgotPasswordView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.forgotPasswordView,
      arguments: ForgotPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithForgotPasswordUpdateView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.forgotPasswordUpdateView,
      arguments: ForgotPasswordUpdateViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHomeShellView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.homeShellView,
      arguments: HomeShellViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBarberDetailView({
    _i10.Key? key,
    required int barberId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.barberDetailView,
      arguments: BarberDetailViewArguments(key: key, barberId: barberId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBookingView({
    _i10.Key? key,
    required int barberId,
    required int serviceId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bookingView,
      arguments: BookingViewArguments(
        key: key,
        barberId: barberId,
        serviceId: serviceId,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
