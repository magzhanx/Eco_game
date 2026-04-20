import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_page.dart';
import 'about_page.dart';
import '../main_layout.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Главная',
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [

          // 🔹 Заголовок
          Text(
            'Экологическое образование',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 16),

          // 🔹 Картинка
          Image.asset('lib/assets/images/nature.jpg'),

          SizedBox(height: 16),

          // 🔹 Текст
          Text(
            'Это приложение направлено на формирование экологических компетенций у студентов. '
                'Здесь вы найдете полезные материалы, видео и ресурсы по устойчивому развитию, '
                'экологии и защите окружающей среды.',
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 20),

          // 🔹 Кнопка (видео)
          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse('https://www.youtube.com/watch?v=EtW2rrLHs08');
              await launchUrl(uri);
            },
            child: Text('Смотреть видео об экологии'),
          ),

          SizedBox(height: 10),

          // 🔹 Кнопка (сайт)
          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse('https://www.un.org/sustainabledevelopment/');
              await launchUrl(uri);
            },
            child: Text('Открыть сайт ООН'),
          ),

          SizedBox(height: 20),

          // 🔹 Ещё картинка
          Image.asset('lib/assets/images/depositphotos_72315071-stock-photo-forest-panorama-with-rays-of.jpg'),
        ],
      ),
    );
  }
}
