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

  // Avatar upload is not declared here: it needs a per-file, dynamically
  // detected multipart Content-Type (see ProfileRepositoryImpl), which
  // Retrofit's @Part only supports as a fixed string.

  @GET('/customer/get-logged-in-user')
  Future<LoggedInUserResponse> getLoggedInUser();
}
