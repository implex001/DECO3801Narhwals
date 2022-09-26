import 'package:caravaneering/model/story.dart';

class EpisodeFactory {

  static const Map<String, List<EpisodeChunk>> _episodes = {
    'W1E1': [
      EpisodeChunk('Tester 1', 'assets/images/placeholders/E1.1.png'),
      EpisodeChunk('Tester 2', 'assets/images/placeholders/E1.2.png')]
  };

  static Episode createEpisode(String episodeName) {
    try {
      return Episode(_episodes[episodeName]!);
    } catch (e) {
      throw Exception("Episode not found");
    }
  }
}

class WorldFactory {
    static final Map<String, World> _worlds = {
      'W1': World('assets/images/placeholders/W1.png', [
        EpisodeFactory.createEpisode('W1E1'),
        EpisodeFactory.createEpisode('W1E2'),
      ])
    };

    static World createWorld(String worldName) {
      try {
        return _worlds[worldName]!;
      } catch (e) {
        throw Exception("World not found");
      }
    }
}