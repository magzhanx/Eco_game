import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'app_state.dart';


class TaskDetailPage extends StatefulWidget {
  final int level;

  const TaskDetailPage({
    required this.level,

  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera, // 📸 можно заменить на gallery
    );

    if (pickedFile != null) {

      // 👇 считаем задание выполненным после загрузки фото
      final appState = Provider.of<AppState>(context, listen: false);

      appState.completeTask(
        widget.level,
        pickedFile.path,
      );
    }
  }


  @override

  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    String? imagePath = appState.taskImages[widget.level];
    bool isCompleted = appState.completedTasks.contains(widget.level);

    return Scaffold(
      appBar: AppBar(
        title: Text('Задание ${widget.level}'),
        backgroundColor: Colors.green,

      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              'Задание ${widget.level}:\n\nТекст Задания',
              style: TextStyle(fontSize: 18),
            ),

            if (imagePath != null)
              Image.file(File(imagePath), height: 200),

            SizedBox(height: 20),

            if (!isCompleted)
            ElevatedButton(
              onPressed: _pickImage,
                //   () {
                // // считаем что пользователь выполнил задание
              // },
              child: Text('Загрузить фото'),
            ),
            if (isCompleted)
              Text(
                'Задание уже выполнено',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}