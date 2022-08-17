import "package:health/health.dart";
import "package:pedometer/pedometer.dart";

class StepTracker {

  final HealthFactory health;
  Stream<StepCount> stepStream;
  int liveSteps;

  StepTracker()
      : health = HealthFactory(),
        liveSteps = 0,
        stepStream = Pedometer.stepCountStream
  {
    stepStream.listen(_onStepCount);
  }

  Future<int?> getBackgroundStepData(DateTime startTime, DateTime endTime) async {
    var types = [HealthDataType.STEPS];
    var permissions = [HealthDataAccess.READ];

    bool authorised = await health.requestAuthorization(
        types, permissions: permissions);

    if (authorised) {
      return await health.getTotalStepsInInterval(startTime, endTime);
    }
    return null;
  }

  void _onStepCount(StepCount event) {
    liveSteps += event.steps;
  }
}