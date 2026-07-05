import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';

/// Replaces `Screen/favourite.dart`. The original screen never called a real
/// API (no favorites endpoint exists in `ApiRequests`) — it rendered a static
/// list of 5 dummy entries. Preserved as-is; wiring this to a real backend is
/// a separate feature, not part of this architecture migration.
class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSurface,
      appBar: AppBar(
        title: const Text('Favourite Barbers', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.darkSurface,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              color: AppColors.darkSurface,
              elevation: 2,
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text(
                  'SK Hair Style',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: const Text('Location: Satdobato', style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  color: Colors.red,
                  onPressed: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
