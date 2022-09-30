import 'package:caravaneering/model/story.dart';
import 'package:flame/components.dart';

class EpisodeFactory {

  static const Map<String, List<EpisodeChunk>> _episodes = {
    'W1E1': [
      EpisodeChunk('Tester 1', 'assets/images/placeholders/E1.1.png'),
      EpisodeChunk('Tester 2', 'assets/images/placeholders/E1.2.png')],
    'W1E2': [
      EpisodeChunk('Tester 1', 'assets/images/placeholders/E1.1.png'),
      EpisodeChunk('Tester 2', 'assets/images/placeholders/E1.2.png')],
    'W1E3': [
      EpisodeChunk('Tester 1', 'assets/images/placeholders/E1.1.png'),
      EpisodeChunk('Tester 2', 'assets/images/placeholders/E1.2.png')],
    'W1E4': [
      EpisodeChunk('Tester 1', 'assets/images/placeholders/E1.1.png'),
      EpisodeChunk('Tester 2', 'assets/images/placeholders/E1.2.png')],
    'W1E5': [
      EpisodeChunk('Tester 1', 'assets/images/placeholders/E1.1.png'),
      EpisodeChunk('Tester 2', 'assets/images/placeholders/E1.2.png')]
  };

  static final Map<String, Vector2> _episodePositions = {
    'W1E1': Vector2(150, 690),
    'W1E2': Vector2(390, 485),
    'W1E3': Vector2(540, 280),
    'W1E4': Vector2(800, 215),
    'W1E5': Vector2(1100, 215),
  };

  static Episode createEpisode(String episodeName) {
    try {
      return Episode(episodeName,
          _episodes[episodeName]!,
          position: _episodePositions[episodeName]);
    } catch (e) {
      throw Exception("Episode not found");
    }
  }
}

class WorldFactory {
    static final Map<String, World> _worlds = {
      'W1': World('background/StoryMap.png', [
        EpisodeFactory.createEpisode('W1E1'),
        EpisodeFactory.createEpisode('W1E2'),
        EpisodeFactory.createEpisode('W1E3'),
        EpisodeFactory.createEpisode('W1E4'),
        EpisodeFactory.createEpisode('W1E5'),
      ])
    };

    static World createWorld(String worldName) {
      try {
        return _worlds[worldName]!;
      } catch (e) {
        throw Exception("Error constructing world: $e");
      }
    }
}