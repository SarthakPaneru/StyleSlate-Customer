import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/home/appointments_view.dart';
import 'package:hamro_barber_mobile/features/home/favorites_view.dart';
import 'package:hamro_barber_mobile/features/home/home_shell_viewmodel.dart';
import 'package:hamro_barber_mobile/features/home/home_view.dart';
import 'package:hamro_barber_mobile/profile/profile_screen.dart';
import 'package:hamro_barber_mobile/socket/user_search.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';
import 'package:stacked/stacked.dart';

class HomeShellView extends StackedView<HomeShellViewModel> {
  const HomeShellView({super.key});

  static const _tabs = [
    HomeView(),
    FavoritesView(),
    AppointmentsView(),
    Scaffold(body: ProfileScreen()),
  ];

  @override
  HomeShellViewModel viewModelBuilder(BuildContext context) => HomeShellViewModel();

  @override
  void onViewModelReady(HomeShellViewModel viewModel) => viewModel.init();

  @override
  Widget builder(BuildContext context, HomeShellViewModel viewModel, Widget? child) {
    return Scaffold(
      body: IndexedStack(index: viewModel.selectedIndex, children: _tabs),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Chat',
        onPressed: viewModel.customerId == null
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(viewModel.customerId!, viewModel.longitude, viewModel.latitude),
                  ),
                ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.selectedIndex,
        onTap: viewModel.selectTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.darkSurface,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
