import 'package:flame/components.dart';
import 'package:flutter/material.dart';

mixin Coordinates {
  Vector2 position = Vector2.zero();
}

mixin Sequence<T> {
  int get currentSequence;
  T next();
  T previous();
}

class EpisodeChunk {
  final String text;
  final String imagePath;

  const EpisodeChunk(this.text, this.imagePath);

  Image getImage() {
    return Image.asset(imagePath);
  }
}

class Episode with Sequence<EpisodeChunk>, Coordinates {
  final List<EpisodeChunk> _story = [];
  int _currentSequence = -1;

  @override
  int get currentSequence => _currentSequence;

  Episode(List<EpisodeChunk> story, {Vector2? position}) {
    this.position = position ?? Vector2.zero();
    _story.addAll(story);
  }

  @override
  EpisodeChunk next() {
    if (_currentSequence < _story.length - 1) {
      _currentSequence++;
    }
    return _story[_currentSequence];
  }

  @override
  EpisodeChunk previous() {
    if (_currentSequence > 0) {
      _currentSequence--;
    }
    return _story[_currentSequence];
  }
}

class World {
  final List<Episode> _episodes;
  final backgroundImagePath;

  World(this.backgroundImagePath, this._episodes);

  Episode getEpisode(int index) {
    return _episodes[index];
  }

  Iterable<Episode> get episodes => _episodes;
}