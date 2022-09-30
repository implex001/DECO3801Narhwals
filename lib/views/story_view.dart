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
        Align(
            alignment: Alignment.bottomCenter,
            child: TextBubble(
              text: _currentChunk!.text,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
            )),
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
    if (!widget.episode.hasNext()) {
      widget.onEnd();
      return;
    }

    setState(() {
      _currentChunk = widget.episode.next();
    });
  }
}
