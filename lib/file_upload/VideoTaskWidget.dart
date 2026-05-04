import 'dart:io';

import 'package:ecogame/pages/app_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';


class VideoTaskWidget extends StatefulWidget {
  final int level;

  const VideoTaskWidget({required this.level});

  @override
  State<VideoTaskWidget> createState() => _VideoTaskWidgetState();
}

class _VideoTaskWidgetState extends State<VideoTaskWidget> {
  File? video;
  VideoPlayerController? _controller;


  Future<void> pickVideo() async {
    final picked = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

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

  void submit() {
    if (video == null) return;

    final appState = Provider.of<AppState>(context, listen: false);
    appState.completeTask(
      widget.level,
      {
        'video': video!.path,

      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: pickVideo,
          child: Text('Записать видео'),
        ),
        ElevatedButton(
          onPressed: submit,
          child: Text('Отправить видео'),
        ),
      ],
    );
  }
}

class VideoPreview extends StatefulWidget {
  final String url;

  const VideoPreview({super.key, required this.url});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: 500,

          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ),
        IconButton(
          icon: Icon(
            _controller!.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
        ),
      ],
    );
  }
}