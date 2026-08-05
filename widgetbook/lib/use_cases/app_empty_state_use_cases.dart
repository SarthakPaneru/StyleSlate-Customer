import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Empty result (no retry)', type: AppEmptyState)
Widget emptyResultUseCase(BuildContext context) {
  return AppEmptyState(
    message: context.knobs.string(
      label: 'Message',
      initialValue: 'No favourites yet.\nBarbers you favourite will show up here.',
    ),
  );
}

@widgetbook.UseCase(name: 'Error (with retry)', type: AppEmptyState)
Widget errorWithRetryUseCase(BuildContext context) {
  return AppEmptyState(
    icon: Icons.wifi_off,
    message: 'Could not load barbers.',
    onRetry: () {},
  );
}
