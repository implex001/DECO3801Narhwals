import "package:health/health.dart";
import "package:pedometer/pedometer.dart";
import 'package:permission_handler/permission_handler.dart';

/// Tracks steps of the user live, and queries third party services for
/// background steps
class StepTracker {
  final HealthFactory health;
  Stream<StepCount> stepStream;
  int liveSteps = 0;
  int lastPedometer = -1;

  StepTracker()
      : health = HealthFactory(),
        stepStream = Pedometer.stepCountStream;

  /// Returns the AppleHealthKit or Google Fit step data between the specified
  /// times as an integer.
  Future<int?> getBackgroundStepData(
      DateTime startTime, DateTime endTime) async {
    var types = [HealthDataType.STEPS];
    var permissions = [HealthDataAccess.READ];

    bool authorised =
        await health.requestAuthorization(types, permissions: permissions);

    if (authorised) {
      int? steps = await health.getTotalStepsInInterval(startTime, endTime);
      return steps;
    }
    return null;
  }

  /// Request Physical Activity Permission
  Future<bool> requestPermission() async {
    return await Permission.activityRecognition.request().isGranted;
  }

  /// Returns a stream of the number of steps taken starting from 0
  Stream<int> getStepStream() async* {
    await for (final event in stepStream) {
      if (lastPedometer != -1) {
        liveSteps += event.steps - lastPedometer;
      }
      lastPedometer = event.steps;
      yield liveSteps;
    }
  }
}
