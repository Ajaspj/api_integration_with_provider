import 'dart:convert';

import 'package:api_integration_with_provider/model/newsapiresponsemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  List<String> Country = [
    "ae",
    "ar",
    "ata",
    "ub",
    "eb",
    "gb",
    "rc",
    "ach",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "eg",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "in",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za"
  ];

  Newsresponsemodel? rescatagory;
  int selectedcatagory = 0;
  int selectedcountry = 0;
  bool isloading = false;

  Future getdata() async {
    isloading = true;
    notifyListeners();
    //step 1
    Uri url = Uri.parse(
        " https://newsapi.org/v2/top-headlines?country=${Country[selectedcountry]}de&category=${categories[selectedcatagory]}&apiKey=42a249660a5c4f4d81758fe27217b905");

    //step 2
    var res = await http.get(url);

    //step 3
    if (res.statusCode == 200) {
      //step 4 decode
      var decodedata = jsonDecode(res.body);

      //step 5 convert to model class
      rescatagory = Newsresponsemodel.fromJson(decodedata);
      //step 6 state update
    } else {
      print("failed");
    }
    isloading = false;
    notifyListeners();
  }

  //on category selection
  oncatagoryselection(int value) {
    selectedcatagory = value;
    notifyListeners();
    getdata();
  }

  //on country selection
  oncountryselection(int value) {
    selectedcountry = value;
    notifyListeners();
    getdata();
  }
}
