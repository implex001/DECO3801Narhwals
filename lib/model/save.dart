import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/s3_integration.dart';

class SaveState {
  static const String _saveFilename = "save";
  final S3Integration _s3Instance = S3Integration();
  String _deviceId = "";

  // Loads the default state values from app_settings.json file. If you would
  // like more items added to the state then please add it into the
  // app_settings.json file.
  Map<String, dynamic> _state = Map.from(GlobalConfiguration().getValue("stateDefaults"));

  // Saves the state
  Future<bool> save() async {
    Future localDone = createLocalSave();
    if (GlobalConfiguration().getValue("cloudSaveOn")) {
      Future cloudDone = createCloudSave();
      Future.wait([localDone, cloudDone]);
    }
    return await localDone;
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

  // Resets the state data. Note this does not delete the local or cloud file
  void resetData() {
    _state = Map.from(GlobalConfiguration().getValue("stateDefaults"));
    _state[SaveKeysV1.horses] = [];
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
    return jsonDecode(userPreviousState)['deviceId'] == _deviceId;
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
    _deviceId = result;
    return true;
  }

  // Store the data from the JSON load file into the save state
  Future<void> loadFromJson(Map<String, dynamic> json) async {
    for (String key in state.keys) {
      state[key] = json[key];
    }
  }

  // Get the path to the app location folder on the device
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Get the current save file
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_saveFilename');
  }

  // Getter for device ID
  String get deviceId => _deviceId;

  // Setter for device ID
  set deviceId(String value) {
    _deviceId = value;
  }

  // Getter for state variable
  Map<String, dynamic> get state => _state;

  // Setter for state variable
  set state(Map<String, dynamic> value) {
    _state = value;
  }
}
