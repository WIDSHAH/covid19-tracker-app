import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/WorldStatesModel.dart';
import 'Utilities/app_url.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    // final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    var data;

    final response = await http.get(Uri.parse('http://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;

    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
