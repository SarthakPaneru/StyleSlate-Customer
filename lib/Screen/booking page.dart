import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/appointments/appointment_repository_factory.dart';
import 'package:hamro_barber_mobile/features/booking/viewmodel/booking_view_model.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';
import 'package:hamro_barber_mobile/utils/khaltihome.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.barberId, required this.serviceId});

  final int barberId;
  final int serviceId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel(createAppointmentRepository()),
      child: _BookingView(barberId: barberId, serviceId: serviceId),
    );
  }
}

class _BookingView extends StatefulWidget {
  const _BookingView({required this.barberId, required this.serviceId});

  final int barberId;
  final int serviceId;

  @override
  State<_BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<_BookingView> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  static const _serviceTimeMinutes = 60;

  Future<void> _submit(BookingViewModel viewModel) async {
    final desiredTime = TimeOfDay(hour: _currentIndex! + 9, minute: 0);
    final appointmentDateTime = DateTime(
      _focusDay.year,
      _focusDay.month,
      _focusDay.day,
      desiredTime.hour,
      desiredTime.minute,
    );

    final startMillis = appointmentDateTime.toUtc().millisecondsSinceEpoch;
    final endMillis = startMillis +
        const Duration(minutes: _serviceTimeMinutes).inMilliseconds;

    final success = await viewModel.createAppointment(
      bookingStart: startMillis ~/ 1000,
      bookingEnd: endMillis ~/ 1000,
      barberId: widget.barberId,
      serviceId: widget.serviceId,
    );

    if (!mounted) return;
    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppStrings.bookingSuccessTitle),
          content: const Text(AppStrings.bookingSuccessBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PaymentPage()),
              ),
              child: const Text(AppStrings.bookingPaymentAction),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false,
              ),
              child: const Text(AppStrings.ok),
            ),
          ],
        ),
      );
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.bookingFailedGeneric,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookingViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.bookingAppBarTitle),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(colorScheme),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      AppStrings.bookingSelectConsultationTime,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.bookingTuesdayUnavailable,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final isSelected = _currentIndex == index;
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: isSelected ? colorScheme.primary : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.5),
                ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: AppPrimaryButton(
                label: AppStrings.bookingMakeAppointment,
                isLoading: viewModel.status == ViewStatus.loading,
                onPressed: (_timeSelected && _dateSelected)
                    ? () => _submit(viewModel)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCalendar(ColorScheme colorScheme) {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(DateTime.now().year + 1, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: colorScheme.secondary, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      onPageChanged: (focusedDay) => _focusDay = focusedDay,
      onFormatChanged: (format) => setState(() => _format = format),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          if (selectedDay.weekday == 2) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      },
    );
  }
}
