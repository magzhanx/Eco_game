import 'package:ecogame/file_upload/VideoTaskWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/submission_service.dart';
import 'package:video_player/video_player.dart';


class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          backgroundColor: Colors.green,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Задания'),
              Tab(text: 'Пользователи'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PendingSubmissionsTab(),
            UsersSurveyTab(),
          ],
        ),
      ),
    );
  }
}

class PendingSubmissionsTab extends StatelessWidget {
  const PendingSubmissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: SubmissionService.getPendingSubmissions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final submissions = snapshot.data!.docs;

        if (submissions.isEmpty) {
          return const Center(
            child: Text('Нет заданий на проверку'),
          );
        }

        return ListView.builder(
          itemCount: submissions.length,
          itemBuilder: (context, index) {
            final doc = submissions[index];
            final data = doc.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'От: ${data['name'] ?? 'Unknown'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      data['taskTitle'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      data['taskDescription'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (data['text'] != null)
                      Text(data['text']),

                    if (data['videoUrl'] != null)
                      VideoPreview(url: data['videoUrl']),

                    if (data['imageUrl'] != null)
                      Image.network(
                        data['imageUrl'],
                        height: 200,
                      ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await SubmissionService
                                .approveSubmission(
                              submissionId: doc.id,
                              userId: data['userId'],
                              taskId: data['taskId'],
                              taskBlock: data['taskBlock'],

                            );
                          },
                          child: const Text('Approve'),
                        ),

                        const SizedBox(width: 10),

                        ElevatedButton(
                          onPressed: () async {
                            await SubmissionService
                                .rejectSubmission(
                              submissionId: doc.id,
                              feedback: 'Попробуйте снова',
                            );
                          },
                          child: const Text('Reject'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
final Map<String, String> surveyQuestions = {
  'q1': 'Я понимаю принципы устойчивого развития',
  'q2': 'Я знаком(а) с глобальными экологическими проблемами',
  'q3': 'Я понимаю роль человека в сохранении окружающей среды',
  'q4': 'Я знаю, какие действия помогают снижать экологический вред',

  'q5': 'Экологические проблемы вызывают у меня личную обеспокоенность',
  'q6': 'Я считаю важным экологическое образование',
  'q7': 'Я готов(а) менять своё поведение ради защиты окружающей среды',
  'q8': 'Я чувствую личную ответственность за состояние природы',

  'q9': 'Я стараюсь соблюдать экологически ответственное поведение',
  'q10': 'Я участвую или готов(а) участвовать в экологических инициативах',
  'q11': 'Я применяю экологические знания в повседневной жизни',
  'q12': 'Я готов(а) обучать других экологически ответственному поведению',

  'q13': 'Я понимаю, как можно формировать экологические компетенции у других',
  'q14': 'Я считаю, что экологическое образование должно быть интегрировано в учебный процесс',
  'q15': 'Я готов(а) использовать педагогические методы для экологического воспитания',
  'q16': 'Я умею объяснять экологические проблемы другим людям',
  'q17': 'Я считаю важным развитие экологической культуры у студентов',
};

class UsersSurveyTab extends StatelessWidget {
  const UsersSurveyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'student')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }


        final users = snapshot.data!.docs;



        if (users.isEmpty) {
          return const Center(child: Text('Пользователи не найдены'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final data = users[index].data() as Map<String, dynamic>;

            final surveyAnswers =
                data['surveyAnswers'] as Map<String, dynamic>? ?? {};

            final postSurveyAnswers =
                data['postSurveyAnswers'] as Map<String, dynamic>? ?? {};

            return Card(
              margin: const EdgeInsets.all(12),
              child: ExpansionTile(
                title: Text(data['name'] ?? 'Без имени'),
                subtitle: Text(data['university'] ?? 'Университет не указан'),
                children: [
                  ListTile(title: Text('Возраст: ${data['age'] ?? '-'}')),
                  ListTile(title: Text('Пол: ${data['gender'] ?? '-'}')),
                  ListTile(title: Text('Специальность: ${data['major'] ?? '-'}')),
                  ListTile(title: Text('Курс: ${data['course'] ?? '-'}')),
                  ListTile(title: Text('Опыт изучения экологии: ${data['ecoStudy'] ?? '-'}')),
                  ListTile(title: Text('Участие в экопроектах: ${data['ecoProjects'] ?? '-'}')),
                  ListTile(title: Text('Доп. информация: ${data['about'] ?? '-'}')),
                  ListTile(title: Text('Понятие экологических компетенций: ${data['ecoDefinition'] ?? '-'}')),
                  ListTile(title: Text('Очки: ${data['points'] ?? '-'}')),

                  const Divider(),

                  const ListTile(
                    title: Text(
                      'Ответы на шкалу 1–5',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  ...surveyAnswers.entries.map(
                        (entry) {
                      final questionText = surveyQuestions[entry.key] ?? entry.key;

                      return ListTile(
                        title: Text(questionText),
                        trailing: Text(
                          entry.value.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),

                  const ListTile(
                    title: Text(
                      'Итоговая анкета',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  ...postSurveyAnswers.entries.map(
                        (entry) => ListTile(
                      title: Text(entry.key),
                      trailing: Text(entry.value.toString()),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      'Открытый ответ: ${data['postSurveyOpenAnswer'] ?? '-'}',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}