// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:hamro_barber_widgetbook/use_cases/app_card_use_cases.dart'
    as _hamro_barber_widgetbook_use_cases_app_card_use_cases;
import 'package:hamro_barber_widgetbook/use_cases/app_empty_state_use_cases.dart'
    as _hamro_barber_widgetbook_use_cases_app_empty_state_use_cases;
import 'package:hamro_barber_widgetbook/use_cases/app_primary_button_use_cases.dart'
    as _hamro_barber_widgetbook_use_cases_app_primary_button_use_cases;
import 'package:hamro_barber_widgetbook/use_cases/app_section_header_use_cases.dart'
    as _hamro_barber_widgetbook_use_cases_app_section_header_use_cases;
import 'package:hamro_barber_widgetbook/use_cases/app_text_field_use_cases.dart'
    as _hamro_barber_widgetbook_use_cases_app_text_field_use_cases;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'ui_kit',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'buttons',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppPrimaryButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_primary_button_use_cases
                        .defaultUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Loading',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_primary_button_use_cases
                        .loadingUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'With icon',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_primary_button_use_cases
                        .withIconUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'feedback',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppEmptyState',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Empty result (no retry)',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_empty_state_use_cases
                        .emptyResultUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Error (with retry)',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_empty_state_use_cases
                        .errorWithRetryUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'inputs',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppTextField',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_text_field_use_cases
                        .defaultUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Password',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_text_field_use_cases
                        .passwordUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'navigation',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppSectionHeader',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_section_header_use_cases
                        .defaultUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'With trailing action',
                builder:
                    _hamro_barber_widgetbook_use_cases_app_section_header_use_cases
                        .withTrailingUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'surfaces',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _hamro_barber_widgetbook_use_cases_app_card_use_cases
                    .defaultUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
