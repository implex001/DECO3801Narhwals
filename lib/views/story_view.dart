import 'package:caravaneering/model/story.dart';
import 'package:caravaneering/views/text_bubble.dart';
import 'package:flutter/material.dart';

class EpisodeView extends StatefulWidget {
  const EpisodeView({Key? key, required this.episode, required this.onEnd})
      : super(key: key);

  final Episode episode;
  final VoidCallback onEnd;

  @override
  State<EpisodeView> createState() => _EpisodeViewState();
}

class _EpisodeViewState extends State<EpisodeView> {
  EpisodeChunk? _currentChunk;

  @override
  void initState() {
    _currentChunk = widget.episode.next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _currentChunk!.getImage(),
        TextBubble(text: _currentChunk!.text),
        Text(_currentChunk!.text),
        TextButton(
          onPressed: () {
            nextEpisode();
          },
          child: const Text('Next'),
        ),
      ],
    );
  }

  void nextEpisode() {
    setState(() {
      _currentChunk = widget.episode.next();
      if (_currentChunk == null) {
        widget.onEnd();
      }
    });
  }
}
