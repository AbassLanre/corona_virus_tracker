


import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_helper.dart';

class AllRepository{
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<AllResponse> fetchAllCountryData() async {
    final response = await _helper.get('https://disease.sh/v3/covid-19/all');
    return AllResponse.fromJson(response);
  }
}