import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Biomes are the different environments that the player can explore
enum BiomeType {
  none,
  desert,
  forest,
  mountain,
  plains,
  swamp,
  tundra,
}

mixin Biome {
  BiomeType biomeType = BiomeType.none;
}

mixin Coordinates {
  Vector2 position = Vector2.zero();
}

mixin Sequence<T> {
  int get currentSequence;

  T? next();

  T previous();

  bool hasNext();

  void reset();
}

class EpisodeChunk {
  final String? text;
  final String imagePath;

  const EpisodeChunk(this.text, this.imagePath);

  Image getImage() {
    return Image.asset(imagePath);
  }
}

class Episode with Sequence<EpisodeChunk>, Coordinates, Biome {
  final List<EpisodeChunk> _story;
  final String id;
  int _currentSequence = -1;
  int requiredSteps;

  @override
  int get currentSequence => _currentSequence;

  Episode(this.id, this._story,
      {Vector2? position, this.requiredSteps = 0, biomeType = BiomeType.none}) {
    this.position = position ?? Vector2.zero();
    this.biomeType = biomeType;
  }

  @override
  EpisodeChunk? next() {
    if (_currentSequence < _story.length - 1) {
      _currentSequence++;
    } else {
      _currentSequence = -1;
      return null;
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

  @override
  bool hasNext() {
    return _currentSequence < _story.length - 1;
  }

  @override
  void reset() {
    _currentSequence = -1;
  }
}

/// A world is a collection of [Episode]s
class World {
  final List<Episode> _episodes;
  final backgroundImagePath;

  World(this.backgroundImagePath, this._episodes);

  Episode getEpisode(int index) {
    return _episodes[index];
  }

  Iterable<Episode> get episodes => _episodes;
}
