import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'barber_api.dart';
import 'barber_repository.dart';
import 'models/barber_detail_model.dart';
import 'models/nearest_barber_model.dart';

class BarberRepositoryImpl implements BarberRepository {
  BarberRepositoryImpl(this._barberApi);

  final BarberApi _barberApi;

  @override
  Future<List<NearestBarberModel>> getNearestBarbers({
    required double latitude,
    required double longitude,
  }) async {
    try {
      return await _barberApi.getNearestBarbers(latitude, longitude);
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<BarberDetailModel> getBarberDetail(int barberId) async {
    try {
      return await _barberApi.getBarberDetail(barberId);
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }
}
