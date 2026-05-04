import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostSurveyPage extends StatefulWidget {
  @override
  State<PostSurveyPage> createState() => _PostSurveyPageState();
}

class _PostSurveyPageState extends State<PostSurveyPage> {
  final openAnswerController = TextEditingController();

  final Map<String, double> answers = {
    for (int i = 1; i <= 21; i++) 'post_q$i': 3,
  };

  final Map<String, String> questions = {
    'post_q1': 'Я могу объяснить основные принципы устойчивого развития',
    'post_q2': 'Я хорошо ориентируюсь в современных глобальных экологических проблемах',
    'post_q3': 'Я осознаю влияние деятельности человека на окружающую среду',
    'post_q4': 'Я могу привести конкретные примеры действий, направленных на снижение экологического вреда',

    'post_q5': 'Экологические проблемы стали вызывать у меня более выраженный личный отклик',
    'post_q6': 'Я убежден(а) в значимости экологического образования',
    'post_q7': 'Я намерен(а) менять своё поведение в пользу экологически ответственных решений',
    'post_q8': 'Я ощущаю личную причастность к решению экологических проблем',

    'post_q9': 'В последнее время я стал(а) чаще придерживаться экологически ответственного поведения',
    'post_q10': 'Я проявляю готовность участвовать в экологических инициативах и проектах',
    'post_q11': 'Я применяю полученные экологические знания в повседневной жизни',
    'post_q12': 'Я готов(а) делиться экологическими знаниями с другими',
    'post_q13': 'За последний период я предпринимал(а) конкретные экологически ответственные действия',

    'post_q14': 'Я понимаю способы формирования экологических компетенций у других людей',
    'post_q15': 'Я поддерживаю интеграцию экологического образования в учебный процесс',
    'post_q16': 'Я готов(а) применять педагогические подходы для экологического воспитания',
    'post_q17': 'Я способен(на) доступно объяснять экологические проблемы',
    'post_q18': 'Я считаю развитие экологической культуры важной задачей образования',

    'post_q19': 'Прохождение обучающего модуля повлияло на мое отношение к экологическим вопросам',
    'post_q20': 'Выполнение практических заданий помогло мне лучше понять экологические проблемы',
    'post_q21': 'Я отметил(а) изменения в своем поведении после прохождения курса',
  };

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
      ],
    );
  }

  Future<void> savePostSurvey() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'postSurveyAnswers': answers,
      'postSurveyOpenAnswer': openAnswerController.text,
      'postSurveyCompleted': true,
      'postSurveyCompletedAt': Timestamp.now(),
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Итоговая анкета сохранена')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Итоговая анкета'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Пожалуйста, оцените степень вашего согласия с каждым утверждением по шкале от 1 до 5:\n\n'
                  '1 — полностью не согласен\n'
                  '2 — скорее не согласен\n'
                  '3 — затрудняюсь ответить\n'
                  '4 — скорее согласен\n'
                  '5 — полностью согласен\n\n'
                  'Анкетирование направлено на оценку изменений уровня экологических компетенций после прохождения модуля.',
            ),
            SizedBox(height: 20),

            ...questions.entries.map(
                  (e) => buildQuestion(e.key, e.value),
            ),

            TextField(
              controller: openAnswerController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Как изменилось ваше понимание экологических компетенций?',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: savePostSurvey,
              child: Text('Сохранить итоговую анкету'),
            ),
          ],
        ),
      ),
    );
  }
}