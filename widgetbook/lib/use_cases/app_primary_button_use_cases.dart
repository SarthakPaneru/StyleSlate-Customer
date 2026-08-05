import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppPrimaryButton)
Widget defaultUseCase(BuildContext context) {
  return AppPrimaryButton(
    label: context.knobs.string(label: 'Label', initialValue: 'Log In'),
    onPressed: context.knobs.boolean(label: 'Enabled', initialValue: true)
        ? () {}
        : null,
  );
}

@widgetbook.UseCase(name: 'Loading', type: AppPrimaryButton)
Widget loadingUseCase(BuildContext context) {
  return AppPrimaryButton(
    label: 'Log In',
    isLoading: true,
    onPressed: () {},
  );
}

const _iconChoices = {
  'Arrow forward': Icons.arrow_forward,
  'Check': Icons.check,
  'Download': Icons.download_outlined,
};

@widgetbook.UseCase(name: 'With icon', type: AppPrimaryButton)
Widget withIconUseCase(BuildContext context) {
  return AppPrimaryButton(
    label: 'Continue',
    icon: context.knobs.object.dropdown(
      label: 'Icon',
      labelBuilder: (icon) => _iconChoices.entries
          .firstWhere((entry) => entry.value == icon)
          .key,
      options: _iconChoices.values.toList(),
    ),
    onPressed: () {},
  );
}
