import 'package:pigeon/pigeon.dart';

// Container holding ISO 8601 string representations of time
class HealthDateRange {
  String? fromDate;
  String? toDate;
}

// Class holding APIs relating to communication between Apple HealthKit and
// Google Health Connect
@HostApi()
abstract class HealthApi {

  // Gets the amount of steps within the specified date range
  @async
  int getSteps(HealthDateRange dateRange);
}