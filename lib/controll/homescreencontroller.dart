import 'dart:convert';

import 'package:api_integration_with_provider/model/newsapiresponsemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  Newsresponsemodel? resmodel;
  bool isloading = false;
  Future getdata() async {
    isloading = true;
    notifyListeners();
    //step 1
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=42a249660a5c4f4d81758fe27217b905");

    //step 2
    var res = await http.get(url);

    //step 3
    if (res.statusCode == 200) {
      //step 4 decode
      var decodedata = jsonDecode(res.body);

      //step 5 convert to model class
      resmodel = Newsresponsemodel.fromJson(decodedata);
      //step 6 state update
    } else {
      print("failed");
    }
    isloading = false;
    notifyListeners();
  }
}
