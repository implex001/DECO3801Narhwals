import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

enum JumpPhase {
  idle,
  rising,
  cool
}

enum JumpType {
  up,
  left,
  right
}


class JumpEvent {
  final JumpType type;

  JumpEvent(this.type);
}

class JumpTracker {
  int counter = 0;
  JumpPhase jumpPhase = JumpPhase.idle;
  Timer? _jumpReset;

  Stream<JumpEvent> getJumpStream() async * {
    await for(final event in userAccelerometerEvents) {
      double force = event.y.abs() + event.x.abs() + event.z.abs();

      if (jumpPhase == JumpPhase.idle) {

        // At rising
        if (force > 18) {
          jumpPhase = JumpPhase.rising;

          // Reset jump phase if taking too long
          _jumpReset ??= Timer(const Duration(milliseconds: 1200), (){
            jumpPhase = JumpPhase.idle;
            _jumpReset = null;
          });
          yield JumpEvent(JumpType.up);
        }
      }

      if (jumpPhase == JumpPhase.rising) {
        if (force < 9) {
          _jumpReset?.cancel();
          _jumpReset = null;
          jumpPhase = JumpPhase.cool;
          Timer(const Duration(milliseconds: 500), ()=> jumpPhase = JumpPhase.idle);
        }
      }
    }
  }
}