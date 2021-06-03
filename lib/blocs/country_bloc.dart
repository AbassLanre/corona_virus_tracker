

import 'dart:async';

import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:corona_virus_tracker/repository/country_deets.dart';

class CountryBloc{
  CountryRepository _countryRepository;
  StreamController _countryController;

  StreamSink<ApiResponse<CountryResponse>> get  countrySink => _countryController.sink;
  Stream<ApiResponse<CountryResponse>> get countryStream => _countryController.stream;

  CountryBloc(countryName){
    _countryController= StreamController<ApiResponse<CountryResponse>>();
    _countryRepository = CountryRepository();
    fetchCountryDetails(countryName);
  }

  fetchCountryDetails(String countryName)async{
    countrySink.add(ApiResponse.loading('Fetching Data'));
    try{
      CountryResponse countryResponse= await _countryRepository.fetchCountryDetails(countryName);
     countrySink.add(ApiResponse.completed(countryResponse));
    }catch(e){
      countrySink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _countryController?.close();
  }

}