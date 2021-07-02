

import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_helper.dart';


class CasesGraphRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<dynamic>> fetchCasesDate() async {
    final response = await _helper.get(
        'https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=30');
    return AllCountryGraph
        .fromJson(response)
        .caseDates;
  }

}
class CasesNumberGraphRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<dynamic>> fetchCasesDateNumber() async {
    final response = await _helper.get(
        'https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=30');
    return AllCountryGraph
        .fromJson(response)
        .caseDateNumbers;
  }
}
class DeathGraphRepository{

  ApiBaseHelper _helper =ApiBaseHelper();

  Future<List<dynamic>> fetchDeathDate() async{
    final response = await _helper.get('https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=30');
    return AllCountryGraph.fromJson(response).deathDates;
  }
}

class DeathNumberGraphRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<dynamic>> fetchDeathDateNumber() async {
    final response = await _helper.get(
        'https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=30');
    return AllCountryGraph
        .fromJson(response)
        .deathDateNumbers;
  }
}

class RecoveredGraphRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<dynamic>> fetchRecoveredDate() async {
    final response = await _helper.get(
        'https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=30');
    return AllCountryGraph
        .fromJson(response)
        .recoveredDates;
  }
}

class RecoveredNumberGraphRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<dynamic>> fetchRecoveredDateNumber() async {
    final response = await _helper.get(
        'https://corona.lmao.ninja/v3/covid-19/historical/all?lastdays=30');
    return AllCountryGraph
        .fromJson(response)
        .recoveredDateNumbers;
  }
}
