import 'package:ecogame/pages/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextTaskWidget extends StatefulWidget {
  final int level;

  const TextTaskWidget({required this.level});

  @override
  State<TextTaskWidget> createState() => _TextTaskWidgetState();
}

class _TextTaskWidgetState extends State<TextTaskWidget> {
  final controller = TextEditingController();

  void submit() {
    final appState = Provider.of<AppState>(context, listen: false);

    appState.completeTask(
      widget.level,
      {
        'text': controller.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Введите ответ',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: submit,
          child: Text('Отправить текст'),
        ),
      ],
    );
  }
}