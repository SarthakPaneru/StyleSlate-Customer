import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'models/barber_detail_model.dart';
import 'models/nearest_barber_model.dart';

part 'barber_api.g.dart';

@RestApi()
abstract class BarberApi {
  factory BarberApi(Dio dio) = _BarberApi;

  @GET('/barber/get/nearest')
  Future<List<NearestBarberModel>> getNearestBarbers(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
  );

  @GET('/barber/get/{barberId}')
  Future<BarberDetailModel> getBarberDetail(@Path('barberId') int barberId);
}
