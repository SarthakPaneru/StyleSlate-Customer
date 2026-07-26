import 'package:hamro_barber_mobile/core/network/dio_client.dart';
import 'profile_api.dart';
import 'profile_repository.dart';
import 'profile_repository_impl.dart';

ProfileRepository createProfileRepository() {
  return ProfileRepositoryImpl(ProfileApi(DioClient.instance));
}
