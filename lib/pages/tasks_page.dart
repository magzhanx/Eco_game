import 'package:flutter/material.dart';
import 'TaskDetailPage.dart';
import '../main_layout.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatefulWidget {


  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  Set<int> completedTasks = {};
  int unlockedLevel = 1; // сколько заданий открыто


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MainLayout(
        title: 'Задания',
        body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {

          int level = index + 1;
          bool isUnlocked = level <= appState.unlockedLevel;

          return GestureDetector(
            onTap: isUnlocked
                ? () async {
              // открываем задание
              bool completed = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskDetailPage(
                      level: level,
                  ),
                ),
              );

              // если прошёл — открываем следующий
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
                  'Задание $level',
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