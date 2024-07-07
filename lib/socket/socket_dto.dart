class SocketDto {
  int? customerId;
  int? barberId;
  double? longitude;
  double? latitude;
  double? distance;

  SocketDto(
      {this.customerId,
      this.barberId,
      this.longitude,
      this.latitude,
      this.distance});

  SocketDto.fromMap(Map map)
      : this(
            customerId: map['customerId'],
            barberId: map['barberId'],
            longitude: map['longitude'],
            latitude: map['latitude'],
            distance: map['distance']);

  Map<String, dynamic> asMap() => {
        'customerId': customerId,
        'barberId': barberId,
        'longitude': longitude,
        'latitude': latitude,
        'distance': distance
      };
}
