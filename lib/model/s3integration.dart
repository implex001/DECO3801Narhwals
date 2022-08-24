import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:caravaneering/amplifyconfiguration.dart';

class S3Integration {
  // Configures the S3 bucket instance
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

  // Uploads a file containing and given content
  // Parameters: filename - the name of the file
  //             content - the file contents
  Future<void> upload(String filename, String content) async {
    // Get the phone temp direction and create the file
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
            print('Progress: ${progress.getFractionCompleted()}');
          }
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  // Deletes the file with the filename specified
  Future<void> deleteFile(String filename) async {
    try {
      final result = await Amplify.Storage.remove(key: filename);
      print('Deleted file: ${result.key}');
    } on StorageException catch (e) {
      print('Error deleting file: $e');
    }
  }

  // Checks whether the file exists in the S3 bucket
  Future<bool> isFileExist(String filename) async {
    List<StorageItem> listResults = await listItems();
    for (StorageItem item in listResults) {
      if (item.key == filename) {
        return true;
      }
    }
    return false;
  }

  // Lists all the items in the S3 buckets
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

  // Downloads a file from the S3 bucket
  // Returns the contents of the file as a string
  Future<String> downloadFile(String filename) async {
    // Get the phone document directory and create a file
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = '${documentsDir.path}/$filename.txt';
    final file = File(filepath);

    // Download the file
    try {
      final result = await Amplify.Storage.downloadFile(
        key: filename,
        local: file,
        onProgress: (progress) {
          print('Progress: ${progress.getFractionCompleted()}');
        },
      );

      // Read the file as a string and return the contents
      final contents = result.file.readAsStringSync();
      return contents;
    } on StorageException catch (e) {
      print('Error downloading file: $e');
    }
    return "";
  }
}
