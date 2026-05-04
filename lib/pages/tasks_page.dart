import 'package:ecogame/main_layout.dart';
import 'package:ecogame/pages/app_state.dart';
import 'package:ecogame/pages/block_tasks_page.dart';
import 'package:ecogame/pages/task_model.dart';
import 'package:flutter/material.dart';
import 'post_survey_page.dart';

import 'package:provider/provider.dart';

class TasksPage extends StatefulWidget {


  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AppState>(context, listen: false).loadUserData();
    });
  }


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MainLayout(
        title: 'Задания',
        body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: taskBlocks.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final block = taskBlocks[index];
          int level = index + 1;
          bool isUnlocked = level <= appState.unlockedBlock;

          return GestureDetector(
            onTap: isUnlocked
                ? () {
              if (block.title == 'Итоговая анкета') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostSurveyPage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlockTasksPage(
                      level: level,
                      block: block,
                    ),
                  ),
                );
              }
            }
                : null,

            child: Container(
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: isUnlocked
                    ? Text(
                  block.title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
                    : Icon(Icons.lock, color: Colors.white, size: 40),
              ),
            ),
          );
        },
      ),
    );
  }
}