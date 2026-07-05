import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/home/home_repository.dart';
import 'package:hamro_barber_mobile/utils/khaltihome.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:table_calendar/table_calendar.dart';

/// Replaces `Screen/booking page.dart`.
class BookingViewModel extends BaseViewModel {
  BookingViewModel(this.barberId, this.serviceId);

  final int barberId;
  final int serviceId;
  static const _serviceTimeMinutes = 60;

  final _homeRepository = locator<HomeRepository>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime currentDay = DateTime.now();
  int? selectedTimeIndex;
  bool isWeekend = false;
  bool dateSelected = false;
  bool timeSelected = false;

  bool get canMakeAppointment => dateSelected && timeSelected;

  void onFormatChanged(CalendarFormat format) {
    calendarFormat = format;
    rebuildUi();
  }

  void onPageChanged(DateTime day) {
    focusedDay = day;
  }

  void onDaySelected(DateTime selectedDay, DateTime newFocusedDay) {
    currentDay = selectedDay;
    focusedDay = newFocusedDay;
    dateSelected = true;

    if (selectedDay.weekday == DateTime.tuesday) {
      isWeekend = true;
      timeSelected = false;
      selectedTimeIndex = null;
    } else {
      isWeekend = false;
    }
    rebuildUi();
  }

  void selectTimeSlot(int index) {
    selectedTimeIndex = index;
    timeSelected = true;
    rebuildUi();
  }

  Future<void> makeAppointment() async {
    final desiredTime = TimeOfDay(hour: selectedTimeIndex! + 9, minute: 0);
    final appointmentDateTime = DateTime(
      focusedDay.year,
      focusedDay.month,
      focusedDay.day,
      desiredTime.hour,
      desiredTime.minute,
    );

    final appointmentStart = appointmentDateTime.toUtc().millisecondsSinceEpoch;
    final appointmentEnd =
        appointmentStart + const Duration(minutes: _serviceTimeMinutes).inMilliseconds;

    try {
      await runBusyFuture(_homeRepository.createAppointment(
        appointmentStart ~/ 1000,
        appointmentEnd ~/ 1000,
        barberId,
        serviceId,
      ));
      await _onBookingSucceeded();
    } catch (_) {
      _dialogService.showDialog(title: 'Error', description: 'Failed to book appointment.');
    }
  }

  Future<void> _onBookingSucceeded() async {
    final response = await _dialogService.showDialog(
      title: 'Successfully Booked',
      description: 'Barber has been reserved',
      buttonTitle: 'Payment',
      cancelTitle: 'OK',
    );

    if (response?.confirmed == true) {
      _navigationService.navigateToView(PaymentPage());
    } else {
      _navigationService.navigateTo(Routes.homeShellView);
    }
  }
}
