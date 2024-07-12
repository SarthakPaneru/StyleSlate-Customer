import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/Screen/favourite.dart';

class UserFavorite extends StatelessWidget {
  int customerId;
  UserFavorite({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return FavouritePage(
      customerId: customerId,
    );
  }
}
