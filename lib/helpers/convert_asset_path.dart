String flutterToFlamePath(String path) {
  return path.replaceAll('assets/', '');
}

String flameToFlutterPath(String path) {
  return 'assets/$path';
}