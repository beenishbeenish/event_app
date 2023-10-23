import 'dart:convert';

import 'package:event_app/DataModelClasses/language_reponse_model.dart';
import 'package:event_app/Utils/json_file_manage.dart';
import 'package:event_app/Utils/web_services.dart';
import 'package:flutter/material.dart';

class LanguageClass extends ChangeNotifier {
  LanguageResponseModel? languageResponseModel;
  bool loading = false;
  bool languageEngSelected = true;
  bool languageGermSelected = false;
  selectLanguage({required String value}) {
    if (value == 'eng') {
      languageEngSelected = true;
      languageGermSelected = false;

      notifyListeners();
    } else {
      languageGermSelected = true;
      languageEngSelected = false;
      notifyListeners();
    }
  }

  getLanguageResponse({required String languagename}) async {
    // print('we get data successfully,,,,,,,,,,,,,$languagename');
    loading = true;
    notifyListeners();
    // getLanguageWeb(languagename:languagename ).then((value) {
    //   notifyListeners();
    //   print('we get data successfully,,,,,,,,,,,,,${value}');
    // });
    // loading=false;
    // notifyListeners();
    StatesStorage statesStorage = StatesStorage(fileNameSelect: 1);
    // languageResponseModel=(await getLanguageWeb( languagename: languagename,token: token))!;
    //notifyListeners();
    await statesStorage.readStates().then((value) {
      print('value.............$value');
      // notifyListeners();
      languageResponseModel = LanguageResponseModel.fromJson(jsonDecode(value));
      notifyListeners();
    });
    loading = false;
    notifyListeners();
  }

  getOnlineLanguageResponse({
    required String languagename,
    required var contextVar,
  }) async {
    loading = true;
    notifyListeners();
    languageResponseModel = await getOnlineLanguageWeb(
        languagename: languagename, contextVar: contextVar);
    //notifyListeners();
    loading = false;
    notifyListeners();
  }
}
