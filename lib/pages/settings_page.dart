import 'package:flutter/material.dart';

import '../main_layout.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Настройки',
      body: Center(child: Text('Настройки')),
    );
  }
}