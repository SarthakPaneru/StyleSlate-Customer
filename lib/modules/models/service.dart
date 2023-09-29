import 'package:hamro_barber_mobile/modules/models/barber.dart';

class Service {
  final int? id;
  final String? serviceName;
  final String? fee;
  final String? serviceTimeInMinutes;
  final Barber? barber;
  final String? category;

  Service(
      {this.id,
      this.serviceName,
      this.fee,
      this.serviceTimeInMinutes,
      this.barber,
      this.category});

  Service.fromMap(Map map)
      : this(
            id: map['id'],
            serviceName: map['serviceName'],
            fee: map['fee'],
            serviceTimeInMinutes: map['serviceTimeInMinutes'],
            barber: map['barber'],
            category: map['category']);

  Map<String, dynamic> asMap() => {
        'id': id,
        'serviceName': serviceName,
        'fee': fee,
        'serviceTimeInMinutes': serviceTimeInMinutes,
        'barber': barber,
        'category': category
      };
}
