import 'package:flutter/material.dart';
import '../main_layout.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'О приложении',
      body: Center(child: Text('Информация о приложении')),
    );
  }
}