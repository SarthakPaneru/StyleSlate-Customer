import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:hamro_barber_mobile/data/auth/models/logged_in_user_response.dart';
import 'package:retrofit/retrofit.dart';
import 'models/update_password_request.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio) = _ProfileApi;

  @PUT('/user/update-password')
  Future<void> updatePassword(@Body() UpdatePasswordRequest request);

  @PUT('/user/image/save')
  @MultiPart()
  Future<void> uploadImage(@Part(name: 'file') File file);

  @GET('/customer/get-logged-in-user')
  Future<LoggedInUserResponse> getLoggedInUser();
}
