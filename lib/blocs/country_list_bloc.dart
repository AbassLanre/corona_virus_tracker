

import 'dart:async';

import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:corona_virus_tracker/repository/country_list_deets.dart';

class CountryListDataBloc{
  CountryListRepository _listRepository;
  FlagListRepository _flagRepository;
  StreamController _listController;
  StreamController _flagController;

  StreamSink<ApiResponse<List<dynamic>>> get  listSink => _listController.sink;
  Stream<ApiResponse<List<dynamic>>> get listStream => _listController.stream;
  StreamSink<ApiResponse<List<dynamic>>> get  flagSink => _flagController.sink;
  Stream<ApiResponse<List<dynamic>>> get flagStream => _flagController.stream;

  CountryListDataBloc(){
    _listController= StreamController<ApiResponse<List<dynamic>>>();
    _flagController= StreamController<ApiResponse<List<dynamic>>>();
    _listRepository = CountryListRepository();
    _flagRepository = FlagListRepository();
    fetchCountryListData();
    fetchFlagListData();
  }

  fetchFlagListData()async{
    flagSink.add(ApiResponse.loading('Fetching Data'));
    try{
      print('flag bloc');
      List<dynamic> flagResponse= await _flagRepository.fetchFlagList();
      print(flagResponse[0]);
      flagSink.add(ApiResponse.completed(flagResponse));
    }catch(e){
      flagSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchCountryListData()async{
    listSink.add(ApiResponse.loading('Fetching Data'));
    try{
      print('List bloc');
      List<dynamic> listResponse= await _listRepository.fetchCountryList();
      print(listResponse[0]);
      listSink.add(ApiResponse.completed(listResponse));
    }catch(e){
      listSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _listController?.close();
    _flagController?.close();
  }

}