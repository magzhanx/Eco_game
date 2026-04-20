import 'package:flutter/material.dart';
import 'survey_page.dart';

class ConsentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Согласие'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Уважаемый участник!\n\n'
                      'Данное исследование направлено на изучение уровня сформированности экологических компетенций студентов.\n\n'
                      'Все данные являются анонимными и будут использованы исключительно в научных целях.\n\n'
                      'Участие является добровольным.\n\n'
                      'Нажимая «Продолжить», вы подтверждаете своё согласие на участие.\n\n'
                      'Подробности вы можете узнать по номеру +7 705 794 00 16',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SurveyPage()),
                );
              },
              child: Text('Продолжить'),
            ),
          ],
        ),
      ),
    );
  }
}