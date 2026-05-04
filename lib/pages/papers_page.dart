import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_page.dart';
import 'about_page.dart';
import '../main_layout.dart';


class PapersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Научные Статьи по Теме',
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [

          // 🔹 Кнопка (сайт)
          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse('https://www.frontiersin.org/journals/education/articles/10.3389/feduc.2026.1803357/abstract');
              await launchUrl(uri);
            },
            child: Text("1)	Limits of Continuous Environmental Education in Developing Environmental Competencies Among Master's students in the Republic of Kazakhstan"),
          ),

          SizedBox(height: 40),


          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse('https://doi.org/10.52269/NTDG254224');
              await launchUrl(uri);
            },
            child: Text("2)	Системный подход в формировании экологических компетенций обучающихся  "),
          ),

          SizedBox(height: 40),

          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse('https://smart.enu.kz/api/serve?path=/general/files/a2384e43-96fc-481c-8985-c5fc09795ea1.pdf ');
              await launchUrl(uri);
            },
            child: Text("3)	AN AXIOLOGICAL APPROACH TO THE DEVELOPMENT OF ENVIRONMENTAL COMPETENCIES OF STUDENTS OF PEDAGOGICAL FIELDS"),
          ),

          SizedBox(height: 20),

        ],
      ),
    );
  }
}
