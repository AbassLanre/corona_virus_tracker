

import 'dart:async';

import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:corona_virus_tracker/repository/all_records.dart';

class AllDataBloc{
  AllRepository _allRepository;
  StreamController _allController;

  StreamSink<ApiResponse<AllResponse>> get  allSink => _allController.sink;
  Stream<ApiResponse<AllResponse>> get allStream => _allController.stream;

  AllDataBloc(){
    _allController= StreamController<ApiResponse<AllResponse>>();
    _allRepository = AllRepository();
    fetchAllCountryData();
  }

  fetchAllCountryData()async{
    allSink.add(ApiResponse.loading('Fetching Data'));
    try{
      AllResponse allResponse= await _allRepository.fetchAllCountryData();
      allSink.add(ApiResponse.completed(allResponse));
    }catch(e){
      allSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _allController?.close();
  }

}