import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/home/booking_viewmodel.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_button.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingView extends StackedView<BookingViewModel> {
  const BookingView({super.key, required this.barberId, required this.serviceId});

  final int barberId;
  final int serviceId;

  @override
  BookingViewModel viewModelBuilder(BuildContext context) => BookingViewModel(barberId, serviceId);

  @override
  Widget builder(BuildContext context, BookingViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointment')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: viewModel.focusedDay,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(DateTime.now().year + 1, 12, 31),
                  calendarFormat: viewModel.calendarFormat,
                  currentDay: viewModel.currentDay,
                  rowHeight: 48,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  ),
                  availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                  onPageChanged: viewModel.onPageChanged,
                  onFormatChanged: viewModel.onFormatChanged,
                  onDaySelected: viewModel.onDaySelected,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (viewModel.isWeekend)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Center(
                  child: Text(
                    'Tuesday is not available, please select another date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ),
            )
          else
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final isSelected = viewModel.selectedTimeIndex == index;
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => viewModel.selectTimeSlot(index),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: isSelected ? Colors.white : Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        color: isSelected ? AppColors.primary : null,
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
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.5),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: AppButton(
                label: 'Make Appointment',
                isLoading: viewModel.isBusy,
                isEnabled: viewModel.canMakeAppointment,
                onPressed: viewModel.makeAppointment,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
