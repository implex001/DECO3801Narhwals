import 'package:caravaneering/model/save.dart';
import 'package:flutter/material.dart';

void exampleOfHowToUseState(SaveState state) async {
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
}

class ExSave extends StatefulWidget {
  const ExSave({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExSaveState();
}

class _ExSaveState extends State<ExSave> {
  SaveState state = SaveState();

  void _incrementCoins() {
    setState(() {
      state.state["coins"]++;
      state.save();
    });
  }

  void _deleteSave() {
    setState(() {
      state.deleteLocalSave();
      state.resetData();
      state.createLocalSave();
    });
  }

  @override
  void initState() {
    super.initState();
    exampleOfHowToUseState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your device ID is: ${state.deviceId}',
            ),
            const SizedBox(height: 80.0),
            const Text(
              'You get a coin each time you press the + button',
            ),
            Text(
              '${state.state["coins"]} coins',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _deleteSave,
              child: const Text(
                'Delete Save',
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCoins,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
