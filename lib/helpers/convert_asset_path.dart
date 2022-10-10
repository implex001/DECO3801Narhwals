String flutterToFlamePath(String path) {
  return path.replaceAll('assets/images/', '');
}

String flameToFlutterPath(String path) {
  return 'assets/images/$path';
}