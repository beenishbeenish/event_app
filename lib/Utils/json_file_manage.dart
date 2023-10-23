import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StatesStorage {
  int fileNameSelect;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  StatesStorage({required this.fileNameSelect});

  Future<File?> get _localFile async {
    final path = await _localPath;
    if (fileNameSelect == 1) {
      print('|||||||||||||||||||Data stored in states.json|||||||||||||||');
      return File('$path/eng_language.json');
    } else if (fileNameSelect == 2) {
      print('|||||||||||||||||||Data stored in lga.json|||||||||||||||');
      return File('$path/ger_language.json');
    } else if (fileNameSelect == 3) {
      print('|||||||||||||||||||Data stored in wards.json|||||||||||||||');
      return File('$path/wards.json');
    }
  }

  Future<String> readStates() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file!.readAsString();

      print('contents: $contents');

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'sss $e';
    }
  }

  Future<File> writeStates(var response) async {
    final file = await _localFile;

    // Write the file
    return file!.writeAsString(response);
  }
}
