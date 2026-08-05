import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppTextField)
Widget defaultUseCase(BuildContext context) {
  return AppTextField(
    controller: TextEditingController(),
    labelText: context.knobs.string(label: 'Label', initialValue: 'Email'),
    prefixIcon: context.knobs.boolean(label: 'Show prefix icon', initialValue: true)
        ? Icons.email_outlined
        : null,
  );
}

@widgetbook.UseCase(name: 'Password', type: AppTextField)
Widget passwordUseCase(BuildContext context) {
  return AppTextField(
    controller: TextEditingController(),
    labelText: 'Password',
    obscureText: true,
    prefixIcon: Icons.lock_outline,
  );
}
