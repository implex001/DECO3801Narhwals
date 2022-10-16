import 'dart:collection';

/// A work queue that can be used to schedule work to be done in the future.
/// Each work item is executed one after the other in the order they were added.
class WorkQueue {
  final Queue<Function()> _queue = Queue<Function()>();
  bool _isRunning = false;

  /// Adds a work item to the queue.
  void add(Function() work) {
    _queue.add(work);
    Future(release);
  }

  /// Releases the next work item in the queue.
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
