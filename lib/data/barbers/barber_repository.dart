import 'models/barber_detail_model.dart';
import 'models/nearest_barber_model.dart';

abstract class BarberRepository {
  Future<List<NearestBarberModel>> getNearestBarbers({
    required double latitude,
    required double longitude,
  });

  Future<BarberDetailModel> getBarberDetail(int barberId);
}
