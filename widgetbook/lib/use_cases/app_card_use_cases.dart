import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppCard)
Widget defaultUseCase(BuildContext context) {
  return const AppCard(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Service Breakdown', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Any content can go here -- AppCard just supplies the '
            'app-standard elevation, corner radius, and padding.'),
      ],
    ),
  );
}
