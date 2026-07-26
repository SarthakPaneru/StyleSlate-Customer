import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/Screen/detailScreen.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/data/barbers/models/nearest_barber_model.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';

/// Search is client-side, filtering the barbers already fetched for the
/// home screen by name — there is no dedicated search endpoint on the
/// backend today.
class BarberSearchScreen extends StatefulWidget {
  const BarberSearchScreen({super.key, required this.barbers});

  final List<NearestBarberModel> barbers;

  @override
  State<BarberSearchScreen> createState() => _BarberSearchScreenState();
}

class _BarberSearchScreenState extends State<BarberSearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _query = _controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _query.isEmpty
        ? widget.barbers
        : widget.barbers
            .where((barber) =>
                barber.fullName.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: AppTextField(
          controller: _controller,
          labelText: AppStrings.homeFindYourBarber,
          prefixIcon: Icons.search,
          keyboardType: TextInputType.text,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Builder(
          builder: (context) {
            if (widget.barbers.isEmpty) {
              return const AppEmptyState(
                message: AppStrings.searchNothingLoadedYet,
              );
            }
            if (results.isEmpty) {
              return AppEmptyState(
                icon: Icons.search_off,
                message: AppStrings.searchNoMatches(_query),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final barber = results[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(barber.fullName),
                  subtitle: Text(AppStrings.distanceAway(
                      barber.distance.toStringAsFixed(1))),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(barberId: barber.id),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
