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
            '🌱 LEVEL 1 — AWARENESS (ПОНЯТЬ)',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 16),
          Text(
            '🌍 Что такое устойчивое развитие?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          // 🔹 Картинка
          // Image.asset('lib/assets/images/nature.jpg'),

          SizedBox(height: 16),

          // 🔹 Текст
          Text(
            'Это не про «спасти планету когда-нибудь»\n'
            'Это про баланс сейчас:\n'
            '•	🌿 экология\n'
            '•	💰 экономика\n'
            '•	👥 общество\n\n'
              '👉 Идея простая:\n'
            'жить так, чтобы хватило и нам, и будущим поколениям'
          ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 40),

          Text(
            '🧠 Экологические компетенции — это…',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          Text(
            'Не просто «знать про мусор»\n\n'
                'Это когда ты:\n'
                '•	понимаешь экологические проблемы\n'
                '•	умеешь анализировать\n'
                '•	реально действуешь\n\n'
                '👉 знания + мышление + действия = компетенция'
            ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 40),

          Text(
            '🌿 Eco mindset (экологическое мышление)',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          Text(
            'Это не «быть идеальным эко-человеком»\n\n'
                'Это когда ты:\n'
                '•	задаёшь вопрос: а можно экологичнее?\n'
                '•	думаешь о последствиях\n'
                '•	думаешь о последствиях\n\n'
            ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 50),

          Text(
            '🌿 LEVEL 2 — UNDERSTANDING (РАЗОБРАТЬСЯ)',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 16),
          Text(
            '🌫️ Твой экологический след',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          Text(
            'Каждый твой выбор = влияние\n\n'
                '•	еда 🍔\n'
                '•	транспорт 🚗\n'
                '•	покупки 🛍️'
            ,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '👉 даже один человек оставляет «след»\n\n'
                '💡 вопрос: насколько он большой у тебя?\n'
            ,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '🛍️ Осознанное потребление',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            'Не «ничего не покупать»\n'
                'А покупать с умом\n\n'
            '✔ нужно ли мне это?\n'
            '✔ сколько это прослужит?\n'
            '✔ можно ли без этого?\n\n'
            '👉 меньше = лучше'
                ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 30),
          Text(
            '♻️ Раздельный сбор — правда или миф?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            'Миф: «всё равно всё в одну кучу»\n'
                'Реальность: переработка работает, но зависит от нас\n\n'
                '👉 главное:\n'
                '•	сортировать\n'
                '•	уменьшать отходы\n'
                '•	не надеяться только на систему'
            ,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),
          Text(
            '🌡️ Изменение климата (очень коротко)',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            'Температура растёт — это факт\n'
                'Причины:\n'
                '•	выбросы CO₂\n'
                '•	промышленность\n'
                '•	транспорт\n\n'
            '👉 последствия:\n'
            '•	жара\n'
            '•	засухи\n'
            '•	экстремальная погода\n'
            ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 50),

          Text(
            '🌳 LEVEL 3 — ACTION (ДЕЙСТВОВАТЬ)',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            '🚀 Как начать эко-проект?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            'Не нужно «спасать мир сразу»\n\n'
                'Начни с малого:\n'
                '1.	проблема\n'
                '2.	идея\n'
                '3.	команда\n'
                '4.	действие\n\n'
                'даже маленький проект = реальное влияние'
            ,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),

          Text(
            '👉 🌱 Эко-привычки, которые реально работают',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
                '•	многоразовая бутылка\n'
                '•	меньше пластика\n'
                '•	осознанные покупки\n'
                '•	экономия ресурсов\n\n'
                '👉 не идеально, а регулярно'
            ,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),
          Text(
            '🏫 Зелёный кампус',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Университет = идеальная площадка\n\n'
                'Можно внедрить:\n'
                '•	раздельный сбор\n'
                '•	озеленение\n'
                '•	эко-мероприятия\n\n'
            '👉 студенты = драйвер изменений'
            ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 30),
          Text(
            '📱 Цифровой след — это тоже экология',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Да, интернет тоже «загрязняет»\n\n'
                '•	хранение данных = энергия\n'
                '•	стриминг = выбросы\n'
                '👉 даже лайки имеют след 😄\n'

            ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 50),

          Text(
            '🧩 SOFT SKILLS',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          Text(
            '🧠 Эко-лидерство',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Это не про «быть главным»\n\n'
            'Это:\n'
                '•	вдохновлять\n'
                '•	предлагать решения\n'
                '•	брать ответственность\n'
            ,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 30),
          Text(
            '🔍 Критическое мышление',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Не всё, что «эко» — правда\n\n'
                '👉 важно:\n'
                '•	проверять\n'
                '•	анализировать\n'
                '•	не верить трендам слепо\n'
            ,
            style: TextStyle(fontSize: 16),
          ),


          SizedBox(height: 50),

          Text(
            '🔥 ФИНАЛЬНЫЙ БЛОК',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          Text(
            '🌍 Почему это важно?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Потому что:\n\n'
                '•	экология = будущее профессий\n'
                '•	устойчивость = навык\n'
                '•	ответственность = новая норма\n\n'
                '👉 Green IQ = не про клуб\n'
                '👉 это про стиль мышления'
            ,
            style: TextStyle(fontSize: 16),
          ),


          // 🔹 Кнопка (видео)
          // ElevatedButton(
          //   onPressed: () async {
          //     final uri = Uri.parse('https://www.youtube.com/watch?v=EtW2rrLHs08');
          //     await launchUrl(uri);
          //   },
          //   child: Text('Смотреть видео об экологии'),
          // ),

          SizedBox(height: 10),

          // 🔹 Кнопка (сайт)
          // ElevatedButton(
          //   onPressed: () async {
          //     final uri = Uri.parse('https://www.un.org/sustainabledevelopment/');
          //     await launchUrl(uri);
          //   },
          //   child: Text('Открыть сайт ООН'),
          // ),
          //
          // SizedBox(height: 20),
          //
          // // 🔹 Ещё картинка
          // Image.asset('lib/assets/images/depositphotos_72315071-stock-photo-forest-panorama-with-rays-of.jpg'),
        ],
      ),
    );
  }
}
