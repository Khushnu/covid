// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:covid/Modal/world_covid.dart';
import 'package:covid/Services/Utillities/app_url.dart';
import 'package:http/http.dart' as http;
class StatesServices{
  Future<WorldCovid> getData() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldCovid.fromJson(data);
    } else {
      return throw Exception('Error');
    }
  }
  Future<List<dynamic>> getCountryData() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryList));
    if(response.statusCode == 200) { 
      return  data = jsonDecode(response.body);
    } else {
      return throw Exception('Error');
    }
  }
}