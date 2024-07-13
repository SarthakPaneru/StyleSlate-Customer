class SocketDto {
  int? customerId;
  int? barberId;
  double? longitude;
  double? latitude;
  double? distance;
  String? location;
  String? serviceName;
  int? price;
  int? defaultId;

  SocketDto(
      {this.customerId,
      this.barberId,
      this.longitude,
      this.latitude,
      this.distance,
      this.location,
      this.serviceName,
      this.price,
      this.defaultId});

  SocketDto.fromMap(Map map)
      : this(
            customerId: map['customerId'],
            barberId: map['barberId'],
            longitude: map['longitude'],
            latitude: map['latitude'],
            distance: map['distance'],
            location: map['location'],
            serviceName: map['serviceName'],
            price: map['price'],
            defaultId: map['defaultId']);

  Map<String, dynamic> asMap() => {
        'customerId': customerId,
        'barberId': barberId,
        'longitude': longitude,
        'latitude': latitude,
        'distance': distance,
        'location': location,
        'serviceName': serviceName,
        'price': price,
        'defaultId': defaultId
      };
}
