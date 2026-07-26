import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
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
}
