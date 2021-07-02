import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_helper.dart';

class CountryListRepository {

  ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<dynamic>> fetchCountryList() async {
    final response = await _helper.get('https://disease.sh/v3/covid-19/countries');
    return CountryListResponse.fromJson(response).countryList;
  }

}

class FlagListRepository{
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<dynamic>> fetchFlagList() async{
    print('response');
    final response = await _helper.get('https://disease.sh/v3/covid-19/countries');
    return CountryListResponse.fromJson(response).flagList;
  }
}