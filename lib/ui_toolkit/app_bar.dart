import 'package:flutter/material.dart';

/// Single app bar widget superseding `widgets/appbar.dart` (`MyAppBar`) and
/// `widgets/custom_appbar.dart` (`CustomAppBar`).
class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  const AppToolbar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: onBack != null,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBack,
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
