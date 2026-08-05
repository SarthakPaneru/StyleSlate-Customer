import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_section_header.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppSectionHeader)
Widget defaultUseCase(BuildContext context) {
  return AppSectionHeader(
    title: context.knobs.string(label: 'Title', initialValue: 'Recommended Barbers'),
  );
}

@widgetbook.UseCase(name: 'With trailing action', type: AppSectionHeader)
Widget withTrailingUseCase(BuildContext context) {
  return AppSectionHeader(
    title: 'Book Again',
    trailing: TextButton(onPressed: () {}, child: const Text('See all')),
  );
}
