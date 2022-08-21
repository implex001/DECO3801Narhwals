import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'amplifyconfiguration.dart';
import 'dart:async';

class S3Integration {
  Future<void> configureAmplify() async {
    // Add plugins to amplify
    final AmplifyStorageS3 storage = AmplifyStorageS3();
    final AmplifyAuthCognito auth = AmplifyAuthCognito();
    await Amplify.addPlugins([storage, auth]);

    // Try to configure amplify
    try {
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('Tried to configure Amplify and following error occurred: $e');
    }
  }

  Future<void> upload(String filename, String content) async {
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File('${tempDir.path}/$filename.json')
      ..createSync()
      ..writeAsStringSync(content);

    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: filename,
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> deleteFile(String filename) async {
    try {
      final result = await Amplify.Storage.remove(key: filename);
      print('Deleted file: ${result.key}');
    } on StorageException catch (e) {
      print('Error deleting file: $e');
    }
  }

  Future<bool> isFileExist(String filename) async {
    List<StorageItem> listResults = await listItems();
    for (StorageItem item in listResults) {
      if (item.key == filename) {
        return true;
      }
    }
    return false;
  }

  Future<List<StorageItem>> listItems() async {
    List<StorageItem> listItems = <StorageItem>[];
    try {
      final result = await Amplify.Storage.list();
      listItems = result.items;
      print('Got items: $listItems');

    } on StorageException catch (e) {
      print('Error listing items: $e');
    }
    return listItems;
  }

  Future<String> downloadFile(String filename) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = '${documentsDir.path}/$filename.txt';
    final file = File(filepath);

    try {
      final result = await Amplify.Storage.downloadFile(
        key: filename,
        local: file,
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      final contents = result.file.readAsStringSync();
      // Or you can reference the file that is created above
      // final contents = file.readAsStringSync();
      print('Downloaded contents: $contents');
      return contents;
    } on StorageException catch (e) {
      print('Error downloading file: $e');
    }
    return "";
  }
}