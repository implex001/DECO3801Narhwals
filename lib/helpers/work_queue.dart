import 'dart:collection';

class WorkQueue {
  final Queue<Function()> _queue = Queue<Function()>();
  bool _isRunning = false;

  void add(Function() work) {
    _queue.add(work);
    Future(release);
  }

  void release() async {
    if (_queue.isNotEmpty && !_isRunning) {
      _isRunning = true;
      var action = _queue.removeFirst();

      action().then((_) {
        _isRunning = false;
        Future(release);
      });
    }
  }
}