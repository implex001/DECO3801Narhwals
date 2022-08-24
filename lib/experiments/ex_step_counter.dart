
import 'package:caravaneering/model/step_tracker.dart';
import 'package:flutter/material.dart';

class ExStepCounter extends StatefulWidget {
  const ExStepCounter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExStepState();

}

class _ExStepState extends State<ExStepCounter> {

  late StepTracker _tracker;
  late Stream<int> _stepStream;
  int _steps = 0;
  int _prevSteps = 0;

  @override
  void initState() {
    super.initState();
    _tracker = StepTracker();
    _tracker.getBackgroundStepData(
        DateTime.now().subtract(const Duration(days: 1)), DateTime.now())
    .then((value) => _initSteps(value));

  }

  void _initSteps(int? steps) {
    _stepStream = _tracker.getStepStream();
    _stepStream.listen(_onLiveStep);
    _prevSteps = steps!;
    setState(() {
      _steps = _prevSteps;
    });
  }

  void _onLiveStep(int step) {
    setState(() =>
      _steps = step + _prevSteps
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_steps',
      style: Theme.of(context).textTheme.headline4,
    );
  }

}
