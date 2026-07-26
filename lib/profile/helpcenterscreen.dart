import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.helpCenterTitle),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.email),
            title: Text(AppStrings.helpCenterContactUs),
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(AppStrings.helpCenterFaqs),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(AppStrings.helpCenterTerms),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text(AppStrings.helpCenterPrivacy),
          ),
        ],
      ),
    );
  }
}
