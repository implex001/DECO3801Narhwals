import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'dart:convert';
import 'dart:async';

import 's3integration.dart';

class SaveState {
  String _username = '';
  String _deviceId = '';
  int _points = 0;
  S3Integration s3Instance = S3Integration();

  Future<bool> determineDeviceId() async {
    String? result = await PlatformDeviceId.getDeviceId;
    if (result == null) {
      print("Device ID not found!");
      return false;
    }
    _deviceId = result;
    return true;
  }

  Future<bool> checkForLocalSave() async {
    final file = await _localFile;
    return file.exists();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/current');
  }

  Future<bool> loadFromLocal() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      await loadFromJson(jsonDecode(contents));
      return true;

    } catch (e) {
      // If encountering an error, return 0
      return false;
    }
  }

  Future<void> loadFromJson(Map<String, dynamic> json) async {
    _username = json['username'];
    _deviceId = json['deviceId'];
  }

  Future<void> initialiseS3() async {
    await s3Instance.configureAmplify();
  }

  Future<bool> checkUsernameExists() async {
    return await s3Instance.isFileExist(_username);
  }

  Future<bool> checkForDeviceIdMatch() async {
    String userPreviousState = await s3Instance.downloadFile(_username);
    return jsonDecode(userPreviousState)['deviceId'] == _deviceId;
  }

  Future<void> loadFromCloud() async {
    String userPreviousState = await s3Instance.downloadFile(_username);
    loadFromJson(jsonDecode(userPreviousState));
  }

  Future<void> save() async {
    Future localDone = createLocalSave();
    Future cloudDone = createCloudSave();
    Future.wait([localDone, cloudDone]);
  }

  Future<void> createLocalSave() async {
    final file = await _localFile;
    file.writeAsString(jsonEncode(toJson()));
  }

  Future<void> createCloudSave() async {
    await s3Instance.upload(_username, jsonEncode(toJson()));
  }

  Future<void> deleteLocalSave() async {
    final file = await _localFile;
    file.delete();
  }

  Future<void> deleteCloudSave() async {
    await s3Instance.deleteFile(_username);
  }

  Map<String, dynamic> toJson() => {
    'username': _username,
    'deviceId': _deviceId,
  };

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get deviceId => _deviceId;

  set deviceId(String value) {
    _deviceId = value;
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }
}

void exampleOfHowToUseState() async {
  SaveState state = SaveState();
  bool deviceIdFound = await state.determineDeviceId();
  if (!deviceIdFound) {
    // Device ID couldn't be found, can't uniquely save so this would be a big issue!
    return;
  }

  // Check if local save exists
  bool localSaveFound = await state.checkForLocalSave();
  if (localSaveFound) {
    await state.loadFromLocal();
  } else {
    // Prompt for username
  }

  state.initialiseS3();

  // Check the cloudbased save
  bool usernameExists = await state.checkUsernameExists();
  if (usernameExists) {
    bool deviceIdMatch = await state.checkForDeviceIdMatch();
    // if device ID matches then they already have a save file. However if there
    // the username exists but with a different device ID then this is not the
    // same person, so they should be asked to try a different username as that
    // one is taken
    if (deviceIdMatch) {
      state.loadFromCloud();
    } else {
      // Reprompt for a new username
    }

  } else {
    // If the username didn't exist in the cloud, then save to both cloud and local
    state.save;
  }
}

