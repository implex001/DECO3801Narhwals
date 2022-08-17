import 'package:pigeon/pigeon.dart';

// Container holding ISO 8601 string representations of time
class FitDateRange {
  String? fromDate;
  String? toDate;
}

// Class holding APIs relating to communication between Apple HealthKit and
// Google Fit
@HostApi()
abstract class FitApi {

  // Gets the amount of steps within the specified date range
  @async
  int getSteps(FitDateRange dateRange);
}