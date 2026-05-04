
import 'package:ecogame/pages/app_state.dart';
import 'package:ecogame/pages/task_model.dart';
import 'package:ecogame/services/submission_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:ecogame/pages/tasks_page.dart';
import 'package:video_player/video_player.dart';




class TaskDetailPage extends StatefulWidget {
  final int level;
  final Task task;

  const TaskDetailPage({
    required this.level,
    required this.task,

  });



  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  TextEditingController textController = TextEditingController();
  File? image;
  File? video;
  VideoPlayerController? _controller;
  Map<String, dynamic>? existingSubmission;
  bool isLoadingSubmission = true;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future<void> pickVideo() async {
    final picked = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (_controller != null) {
      await _controller!.dispose();
    }

    if (picked != null) {
      setState(() {
        video = File(picked.path);

        _controller = VideoPlayerController.file(video!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  Future<void> submitTask() async {
    await SubmissionService.submitTask(
      taskId: widget.level,
      taskTitle: widget.task.title,
      taskDescription: widget.task.description,
      taskBlock: widget.task.block,
      text: textController.text,
      image: image,
      video: video,
    );

    await loadExistingSubmission();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Отправлено на проверку'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadExistingSubmission();
  }

  Future<void> loadExistingSubmission() async {
    final data = await SubmissionService.getUserSubmission(widget.level);

    if (mounted) {
      setState(() {
        existingSubmission = data;
        isLoadingSubmission = false;

        if (data?['text'] != null) {
          textController.text = data!['text'];
        }
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final result = appState.taskResults[widget.level];



    String? imagePath = result?['image'];
    String? text = result?['text'];
    String? video = result?['video'];
    bool isCompleted = appState.completedTasks.contains(widget.level);



    return Scaffold(
      appBar: AppBar(
        title: Text('Блок: ${widget.task.block}'),
        backgroundColor: Colors.green,

      ),

      body: SafeArea(
    child: SingleChildScrollView(
    child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
    children: [

            // Text(
            //   widget.task.description,
            //   style: TextStyle(fontSize: 18),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8),

                // Text(
                //   'Блок: ${widget.task.block}',
                //   style: TextStyle(color: Colors.grey),
                // ),

                SizedBox(height: 16),

                Text(
                  widget.task.description,
                  style: TextStyle(fontSize: 18),
                ),

                if (widget.task.requirements.contains(TaskRequirement.text))
                  TextField(
                    controller: textController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Введите текст',
                      border: OutlineInputBorder(),
                    ),
                  ),

                if (text != null)
                  Text(text),

                SizedBox(height: 10),

                /// 📸 ФОТО
                if (widget.task.requirements.contains(TaskRequirement.image))
                  Column(
                    children: [
                      if (image != null) Image.file(image!, height: 150),
                      ElevatedButton(
                        onPressed: pickImage,
                        child: Text('Сделать фото'),
                      ),
                    ],
                  ),

                if (imagePath != null)
                  Image.file(
                    File(imagePath),
                    height: 200,
                  ),

                /// 🎥 ВИДЕО
                if (widget.task.requirements.contains(TaskRequirement.video))
                  Column(
                    children: [
                      if (video != null) Text('Видео успешно загружено'),
                  ElevatedButton(
                    onPressed: pickVideo,
                    child: Text('Записать видео'),
                  ),
                    ],
                  ),

                if (video != null)
                  Text('Видео успешно загружено'),

                if (_controller != null && _controller!.value.isInitialized)
                  Container(
                    height: 100,
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
                  ),

                SizedBox(height: 20),

                if (isLoadingSubmission)
                  CircularProgressIndicator(),

                if (existingSubmission != null) ...[
                  SizedBox(height: 20),
                  Text(
                    'Ваш отправленный ответ:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  if (existingSubmission!['text'] != null &&
                      existingSubmission!['text'].toString().isNotEmpty)
                    Text(existingSubmission!['text']),

                  if (existingSubmission!['imageUrl'] != null)
                    Image.network(
                      existingSubmission!['imageUrl'],
                      height: 200,
                    ),

                  if (existingSubmission!['videoUrl'] != null)
                    Text('Видео уже загружено'),

                  Text('Статус: ${existingSubmission!['status']}'),
                ],

                ElevatedButton(
                  onPressed: submitTask,
                  child: Text('Отправить задание'),
                ),




                // if (isCompleted)
                //   Column(
                //     children: [
                //       if (text != null) Text(text),
                //       if (imagePath != null)
                //         Image.file(File(imagePath), height: 200),
                //       if (video != null)
                //         Text('Видео успешно загружено'),
                //     ],
                //   ),
              ],
            ),
          ],
        ),
      ),
      ),
      ),
    );

  }

}