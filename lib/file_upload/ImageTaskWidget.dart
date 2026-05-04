import 'dart:io';

import 'package:ecogame/pages/app_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageTaskWidget extends StatefulWidget {
  final int level;

  const ImageTaskWidget({required this.level});

  @override
  State<ImageTaskWidget> createState() => _ImageTaskWidgetState();
}

class _ImageTaskWidgetState extends State<ImageTaskWidget> {
  File? image;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  void submit() {
    if (image == null) return;

    final appState = Provider.of<AppState>(context, listen: false);
    appState.completeTask(
      widget.level,
      {
        'image': image!.path,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != null) Image.file(image!, height: 200),

        ElevatedButton(
          onPressed: pickImage,
          child: Text('Сделать фото'),
        ),

        ElevatedButton(
          onPressed: submit,
          child: Text('Отправить фото'),
        ),
      ],
    );
  }
}