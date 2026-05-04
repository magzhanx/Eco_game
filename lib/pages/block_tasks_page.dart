import 'package:ecogame/pages/TaskDetailPage.dart';
import 'package:ecogame/pages/app_state.dart';
import 'package:ecogame/pages/task_model.dart';
import 'package:ecogame/pages/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';



class BlockTasksPage extends StatefulWidget {
  final TaskBlock block;
  final int level;

  const BlockTasksPage({
    required this.block,
    required this.level,
  });

  @override
  State<BlockTasksPage> createState() => _BlockTasksPageState();
}

class _BlockTasksPageState extends State<BlockTasksPage> {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.block.title),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: widget.block.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.block.tasks[index];

          int taskLevel = index + 1;
          int uniqueTaskId = '${widget.block.title}_$taskLevel'.hashCode;
          int previousTaskId =
              '${widget.block.title}_${taskLevel - 1}'.hashCode;

          bool isUnlocked = taskLevel == 1 ||
              appState.completedTasks.contains(previousTaskId);

          return ListTile(
            title: Text(task.title),
            trailing: isUnlocked
                ? Icon(Icons.lock_open, color: Colors.green)
                : Icon(Icons.lock, color: Colors.red),
            onTap: () {
              if (!isUnlocked) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Сначала пройдите предыдущее задание')),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskDetailPage(
                    level: uniqueTaskId,
                    task: task,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}