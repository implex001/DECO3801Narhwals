/// Converts a flutter image path to a flame one
String flutterToFlamePath(String path) {
  return path.replaceAll('assets/images/', '');
}

/// Converts a flame image path to a flutter one
String flameToFlutterPath(String path) {
  return 'assets/images/$path';
}
