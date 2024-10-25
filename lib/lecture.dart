import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'model.dart';
import 'note.dart';

class Lecture extends StatefulWidget {
  final int index;
  final LectureItem source;

  const Lecture({
    super.key,
    required this.index,
    required this.source,
  });

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.source.video),
    )..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture ${widget.index}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'more',
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: _controller.value.isInitialized
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_controller),
                        AnimatedOpacity(
                          opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: Center(
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 100.0,
                              color: Theme.of(context).colorScheme.primary,
                              shadows: const [
                                Shadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          }),
                        ),
                        VideoProgressIndicator(
                          _controller,
                          colors: VideoProgressColors(
                            playedColor: Theme.of(context).colorScheme.primary,
                            bufferedColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          allowScrubbing: true,
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(widget.source.introduction),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.value.isInitialized) {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) => Note(
                time: _controller.value.position.toString().split('.')[0],
                note: widget.source.notes[_controller.value.position.inMinutes],
              ),
            );
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              }
            });
          }
        },
        child: const Icon(Icons.note_outlined),
      ),
    );
  }
}
