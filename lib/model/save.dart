import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'dart:convert';
import 'dart:async';

import 'package:caravaneering/model/s3integration.dart';

class SaveState {
  static const String saveFilename = "save";
  final S3Integration _s3Instance = S3Integration();
  bool _cloudSave = false;
  // Values below are stored in state, add more as required.
  // Note: must be in JSON format
  // Possible future values include: Last date of step taken, coins, gems,
  // equipped items, pets, mounts, caravans, story unlocked, achievements, skills
  Map<String, dynamic> _state = {
    'username': '',
    'deviceId': '',
    'coins': 0,
  };

  // Saves the state
  Future<void> save() async {
    Future localDone = createLocalSave();
    if (_cloudSave) {
      Future cloudDone = createCloudSave();
      Future.wait([localDone, cloudDone]);
    } else {
      Future.wait([localDone]);
    }
  }

  // Loads the state from local storage (will overwrite current state)
  // Returns true if the state loaded without error
  Future<bool> loadFromLocal() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      await loadFromJson(jsonDecode(contents));
    } catch (e) {
      return false;
    }
    return true;
  }

  // Returns true if a local save exists
  Future<bool> checkForLocalSave() async {
    final file = await _localFile;
    return file.exists();
  }

  // Creates the local save file, returns true if successful
  Future<bool> createLocalSave() async {
    final file = await _localFile;
    try {
      file.writeAsString(jsonEncode(_state));
    } catch (e) {
      return false;
    }
    return true;
  }

  // Delete the local save file, returns true if successful
  Future<bool> deleteLocalSave() async {
    final file = await _localFile;
    try {
      file.delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  // Turns cloud saving on or off
  void toggleCloudSaving(bool toggleValue) {
    _cloudSave = toggleValue;
  }

  // Configures the Amplify plugin for the S3 instance
  Future<void> initialiseS3() async {
    await _s3Instance.configureAmplify();
  }

  // Returns boolean of whether the username exists in the S3 instance
  Future<bool> checkUsernameExists() async {
    return await _s3Instance.isFileExist(_state["username"]);
  }

  // Returns boolean of whether the device ID matches the stored ID for the username.
  // Important: Run check username exists first to check if file exists
  Future<bool> checkForDeviceIdMatch() async {
    String userPreviousState = await _s3Instance.downloadFile(_state["username"]);
    return jsonDecode(userPreviousState)['deviceId'] == _state["deviceId"];
  }

  // Create the cloud save file
  Future<void> createCloudSave() async {
    await _s3Instance.upload(_state["username"], jsonEncode(_state));
  }

  // Loads the cloud save file. Note this overwrites the local save file.
  // Returns true if save loaded from cloud
  Future<bool> loadFromCloud() async {
    String userPreviousState = await _s3Instance.downloadFile(_state["username"]);
    loadFromJson(jsonDecode(userPreviousState));
    return await createLocalSave();
  }

  // Deletes the cloud save file
  Future<void> deleteCloudSave() async {
    await _s3Instance.deleteFile(_state["username"]);
  }

  // Extracts the device ID. Returns true if device ID was successfully found
  Future<bool> determineDeviceId() async {
    String? result = await PlatformDeviceId.getDeviceId;
    if (result == null) {
      return false;
    }
    _state["deviceId"] = result;
    return true;
  }

  // Store the data from the JSON load file into the save state
  Future<void> loadFromJson(Map<String, dynamic> json) async {
    for (String key in state.keys) {
      state[key] = json[key];
    }
  }

  // Maps the
  // Map<String, dynamic> toJson() => {
  //   return state
  // };

  // Get the path to the app location folder on the device
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Get the current save file
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$saveFilename');
  }

  // Getter for state variable
  Map<String, dynamic> get state => _state;

  // Setter for state variable
  set state(Map<String, dynamic> value) {
    _state = value;
  }
}
