import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import '../main.dart';

class SurveyPage extends StatefulWidget {
  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  final ageController = TextEditingController();
  final universityController = TextEditingController();
  final majorController = TextEditingController();
  final courseController = TextEditingController();
  final aboutController = TextEditingController();
  final nameController = TextEditingController();

  String gender = 'Мужской';
  String ecoStudy = 'Нет';
  String ecoProjects = 'Нет';

  Map<String, double> answers = {
    // Когнитивный
    'q1': 3,
    'q2': 3,
    'q3': 3,
    'q4': 3,
    // Ценностный
    'q5': 3,
    'q6': 3,
    'q7': 3,
    'q8': 3,
    // Поведенческий
    'q9': 3,
    'q10': 3,
    'q11': 3,
    'q12': 3,
    // Педагогический
    'q13': 3,
    'q14': 3,
    'q15': 3,
    'q16': 3,
    'q17': 3,
  };

  final ecoDefinitionController = TextEditingController();

  Future<void> saveSurvey() async {
    try {
      print("START SAVE");

    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'name': nameController.text,
      'age': ageController.text,
      'gender': gender,
      'university': universityController.text,
      'major': majorController.text,
      'course': courseController.text,
      'ecoStudy': ecoStudy,
      'ecoProjects': ecoProjects,
      'about': aboutController.text,
      'surveyAnswers': answers,
      'ecoDefinition': ecoDefinitionController.text,
      'points': 0,
      'unlockedLevel': 1,
      'unlockedBlock': 1,
      'completedTasks': [],
      'role': 'student',
    }, SetOptions(merge: true));

    print("DATA SAVED");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => AuthWrapper()),
          (route) => false,
    );

  } catch (e) {
  print("ERROR: $e");

  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Ошибка: $e')),
  );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Анкета'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Имя'),
            ),

            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Возраст'),
            ),

            DropdownButtonFormField(
              value: gender,
              items: ['Мужской', 'Женский']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => gender = value.toString()),
              decoration: InputDecoration(labelText: 'Пол'),
            ),

            TextField(
              controller: universityController,
              decoration: InputDecoration(labelText: 'Университет'),
            ),

            TextField(
              controller: majorController,
              decoration: InputDecoration(labelText: 'Специальность'),
            ),

            TextField(
              controller: courseController,
              decoration: InputDecoration(labelText: 'Курс'),
            ),

            DropdownButtonFormField(
              value: ecoStudy,
              items: ['Да', 'Нет']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => ecoStudy = value.toString()),
              decoration: InputDecoration(
                  labelText: 'Есть ли опыт изучения экологии?'),
            ),

            DropdownButtonFormField(
              value: ecoProjects,
              items: ['Да', 'Нет']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) =>
                  setState(() => ecoProjects = value.toString()),
              decoration: InputDecoration(
                  labelText: 'Участвовали ли в экологических проектах?'),
            ),

            TextField(
              controller: aboutController,
              decoration: InputDecoration(
                  labelText: 'Дополнительная информация (необязательно)'),
            ),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                  'Пожалуйста, оцените степень вашего согласия с каждым утверждением по шкале от 1 до 5, где:\n\n'
              '1 — полностью не согласен\n'
              '2 — скорее не согласен\n'
              '3 — затрудняюсь ответить\n'
              '4 — скорее согласен\n'
              '5 — полностью согласен\n\n'
              'Данное анкетирование поможет нам понять уровень ваших экологических компетенций и отношения к экологическому образованию.',
                style: TextStyle(fontSize: 16),
              ),
            ),

            Text('1. Когнитивный компонент'),

            buildQuestion('q1', 'Я понимаю принципы устойчивого развития'),
            buildQuestion('q2', 'Я знаком(а) с глобальными экологическими проблемами'),
            buildQuestion('q3', 'Я понимаю роль человека в сохранении окружающей среды'),
            buildQuestion('q4', 'Я знаю, какие действия помогают снижать экологический вред'),

            Text('2. Ценностно-мотивационный'),

            buildQuestion('q5', 'Экологические проблемы вызывают у меня личную обеспокоенность'),
            buildQuestion('q6', 'Я считаю важным экологическое образование'),
            buildQuestion('q7', 'Я готов(а) менять своё поведение ради защиты окружающей среды'),
            buildQuestion('q8', 'Я чувствую личную ответственность за состояние природы'),

            Text('3. Поведенческий'),

            buildQuestion('q9', 'Я стараюсь соблюдать экологически ответственное поведение'),
            buildQuestion('q10', 'Я участвую или готов(а) участвовать в экологических инициативах'),
            buildQuestion('q11', 'Я применяю экологические знания в повседневной жизни'),
            buildQuestion('q12', 'Я готов(а) обучать других экологически ответственному поведению'),

            Text('4. Педагогический'),

            buildQuestion('q13', 'Я понимаю, как можно формировать экологические компетенции у других'),
            buildQuestion('q14', 'Я считаю, что экологическое образование должно быть интегрировано в учебный процесс'),
            buildQuestion('q15', 'Я готов(а) использовать педагогические методы для экологического воспитания'),
            buildQuestion('q16', 'Я умею объяснять экологические проблемы другим людям'),
            buildQuestion('q17', 'Я считаю важным развитие экологической культуры у студентов'),

            TextField(
              controller: ecoDefinitionController,
              decoration: InputDecoration(
                labelText: 'Как вы понимаете понятие экологические компетентции?',
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveSurvey,
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildQuestion(String key, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        Slider(
          value: answers[key]!,
          min: 1,
          max: 5,
          divisions: 4,
          label: answers[key]!.round().toString(),
          onChanged: (value) {
            setState(() {
              answers[key] = value;
            });
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}