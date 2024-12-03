import 'dart:convert';

import 'package:covid_19_app/models/coutries_data_model.dart';
import 'package:covid_19_app/models/world_state_model.dart';
import 'package:covid_19_app/services/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<worldStateModel> fetchWorldStates() async {
    final responce = await http.get(Uri.parse(AppUrl.baseUrl.toString()));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body.toString());
      return worldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  List<countries_data_model> coutriesdataList = [];
  Future<List<countries_data_model>> countriesList() async {
    final responce = await http.get(
        Uri.parse(AppUrl.countriesListURL.toString()),
        headers: {'Accept': 'application/json'});

    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in data) {
        countries_data_model countryList = countries_data_model(
            country: i['country'],
            countryInfo: CountryInfo(flag: i['countryInfo']['flag']));
        coutriesdataList.add(countryList);
      }
      return coutriesdataList;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> newcountriesList() async {
    final responce =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (responce.statusCode == 200) {
      List<dynamic> data = jsonDecode(responce.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
