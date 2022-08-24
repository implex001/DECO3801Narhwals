import 'package:caravaneering/model/save.dart';
import 'package:flutter/material.dart';

void exampleOfHowToUseState() async {
  SaveState state = SaveState();
  bool deviceIdFound = await state.determineDeviceId();
  if (!deviceIdFound) {
    // Device ID couldn't be found
    return;
  }

  // Check if local save exists
  bool localSaveFound = await state.checkForLocalSave();
  if (localSaveFound) {
    await state.loadFromLocal();
  } else {
    state.createLocalSave();
  }

  state.save;
}

class ExSave extends StatefulWidget {
  const ExSave({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExSaveState();
}

class _ExSaveState extends State<ExSave> {
  @override
  void initState() {
    super.initState();
    exampleOfHowToUseState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'test',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
