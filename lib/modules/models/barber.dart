import 'dart:ffi';

import 'package:hamro_barber_mobile/modules/models/service.dart';

import 'user.dart';

class Barber {
  final int? id;
  final String? panNo;
  final bool? isOpened;
  final User? user;
  final String? name;
  final String? imageUrl;
  final List<Service>? services;
  final Float? rating;
  final Double? longitude;
  final Double? latitude;
  final Double? distance;

  Barber(
      {this.id,
      this.panNo,
      this.isOpened,
      this.user,
      this.name,
      this.imageUrl,
      this.services,
      this.rating,
      this.longitude,
      this.latitude,
      this.distance});

  Barber.fromMap(Map map)
      : this(
            id: map['id'],
            panNo: map['panNo'],
            isOpened: map['isOpened'],
            user: map['user'],
            name: map['name'],
            imageUrl: map['imageUrl'],
            services: map['services'],
            rating: map['rating'],
            longitude: map['longitude'],
            latitude: map['latitude'],
            distance: map['distance']
            );

  Map<String, dynamic> asMap() => {
        'id': id,
        'panNo': panNo,
        'isOpened': isOpened,
        'user': user,
        'name': name,
        'imageUrl': imageUrl,
        'services': services,
        'rating': rating,
        'longitude': longitude,
        'latitude': latitude,
        'distance': distance
      };
}
