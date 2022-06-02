import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../utilities/api_exception.dart';
import '../components/custom_dialog_box.dart';
import '../models/quote.dart';
class QuoteApi{

  Future<Quotes?> getQuote()async{
    try {
      bool isConnection = await InternetConnectionChecker().hasConnection;
      if (isConnection)
      {
        final String url = 'https://zenquotes.io/api/today';
        final response = await http.get(Uri.parse(url),);
        if (response.statusCode==200){
          late Quotes quotes;
          List<dynamic> data = json.decode(response.body);
          data.forEach((element){
            quotes=Quotes.fromJson(element);
          });
         return quotes;
        }
      }
    }on ApiException catch(e) {
      Get.dialog(
          CustomDialogBox(
            title: 'Something wrong',
            middleText: '$e',
            onPressed: () {
              Get.back();
            },));
    }
    return null;

  }





}