

import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_helper.dart';

class CountryRepository{
  ApiBaseHelper _helper= ApiBaseHelper();
  Future<CountryResponse> fetchCountryDetails(String countryName) async{
    final response = await _helper.get('https://disease.sh/v3/covid-19/countries/$countryName?strict=true');
    return CountryResponse.fromJson(response);
    
  }
}