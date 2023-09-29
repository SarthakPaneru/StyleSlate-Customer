import 'package:hamro_barber_mobile/modules/models/user.dart';

class Customer {
  final int? id;
  final User? user;

  Customer({this.id, this.user});

  Customer.fromMap(Map map)
      : this(
          id: map['id'],
          user: map['user'],
        );

  Map<String, dynamic> asMap() => {
        'id': id,
        'user': user,
      };
}
