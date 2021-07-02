
import 'dart:async';

import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:corona_virus_tracker/repository/graph_list.dart';

class GraphDataBloc{
  CasesGraphRepository _casesGraphRepository;
  CasesNumberGraphRepository _casesNumberGraphRepository;
  DeathGraphRepository _deathGraphRepository;
  DeathNumberGraphRepository _deathNumberGraphRepository;
  RecoveredGraphRepository _recoveredGraphRepository;
  RecoveredNumberGraphRepository _recoveredNumberGraphRepository;

  StreamController _casesGraphController;
  StreamController _casesNumberGraphController;
  StreamController _deathGraphController;
  StreamController _deathNumberGraphController;
  StreamController _recoveredGraphController;
  StreamController _recoveredNumberGraphController;




  StreamSink<ApiResponse<List<dynamic>>> get  caseGraphSink => _casesGraphController.sink;
  Stream<ApiResponse<List<dynamic>>> get caseGraphStream => _casesGraphController.stream;

  StreamSink<ApiResponse<List<dynamic>>> get  caseNumberGraphSink => _casesNumberGraphController.sink;
  Stream<ApiResponse<List<dynamic>>> get caseNumberGraphStream => _casesNumberGraphController.stream;

  StreamSink<ApiResponse<List<dynamic>>> get  deathGraphSink => _deathGraphController.sink;
  Stream<ApiResponse<List<dynamic>>> get deathGraphStream => _deathGraphController.stream;

  StreamSink<ApiResponse<List<dynamic>>> get  deathNumberGraphSink => _deathNumberGraphController.sink;
  Stream<ApiResponse<List<dynamic>>> get deathNumberGraphStream => _deathNumberGraphController.stream;

  StreamSink<ApiResponse<List<dynamic>>> get  recoveredGraphSink => _recoveredGraphController.sink;
  Stream<ApiResponse<List<dynamic>>> get recoveredGraphStream => _recoveredGraphController.stream;

  StreamSink<ApiResponse<List<dynamic>>> get  recoveredNumberGraphSink => _recoveredNumberGraphController.sink;
  Stream<ApiResponse<List<dynamic>>> get recoveredNumberGraphStream => _recoveredNumberGraphController.stream;





  GraphDataBloc(){
    _casesGraphController= StreamController<ApiResponse<List<dynamic>>>();
    _casesGraphRepository = CasesGraphRepository();
    _casesNumberGraphController= StreamController<ApiResponse<List<dynamic>>>();
    _casesNumberGraphRepository = CasesNumberGraphRepository();
    _deathGraphController= StreamController<ApiResponse<List<dynamic>>>();
    _deathGraphRepository = DeathGraphRepository();
    _deathNumberGraphController= StreamController<ApiResponse<List<dynamic>>>();
    _deathNumberGraphRepository = DeathNumberGraphRepository();
    _recoveredGraphController= StreamController<ApiResponse<List<dynamic>>>();
    _recoveredGraphRepository = RecoveredGraphRepository();
    _recoveredNumberGraphController= StreamController<ApiResponse<List<dynamic>>>();
    _recoveredNumberGraphRepository = RecoveredNumberGraphRepository();

    fetchCasesGraphData();
    fetchCasesNumberGraphData();
    fetchDeathGraphData();
    fetchDeathNumberGraphData();
    fetchRecoveredGraphData();
    fetchRecoveredNumberGraphData();
  }

  fetchCasesGraphData()async{
    caseGraphSink.add(ApiResponse.loading('Fetching Data'));
    try{
      // print('graph bloc');
      List<dynamic> graphResponse= await _casesGraphRepository.fetchCasesDate();
      print(graphResponse[0]);
      caseGraphSink.add(ApiResponse.completed(graphResponse));
    }catch(e){
      caseGraphSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchCasesNumberGraphData()async{
    caseNumberGraphSink.add(ApiResponse.loading('Fetching Data'));
    try{
      // print('graph bloc');
      List<dynamic> graphResponse= await _casesNumberGraphRepository.fetchCasesDateNumber();
      print(graphResponse[0]);
      caseNumberGraphSink.add(ApiResponse.completed(graphResponse));
    }catch(e){
      caseNumberGraphSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchDeathGraphData()async{
    deathGraphSink.add(ApiResponse.loading('Fetching Data'));
    try{
      // print('graph bloc');
      List<dynamic> graphResponse= await _deathGraphRepository.fetchDeathDate();
      print(graphResponse[0]);
      deathGraphSink.add(ApiResponse.completed(graphResponse));
    }catch(e){
      deathGraphSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchDeathNumberGraphData()async{
    deathNumberGraphSink.add(ApiResponse.loading('Fetching Data'));
    try{
      // print('graph bloc');
      List<dynamic> graphResponse= await _deathNumberGraphRepository.fetchDeathDateNumber();
      print(graphResponse[0]);
      deathNumberGraphSink.add(ApiResponse.completed(graphResponse));
    }catch(e){
      deathNumberGraphSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchRecoveredGraphData()async{
    recoveredGraphSink.add(ApiResponse.loading('Fetching Data'));
    try{
      // print('graph bloc');
      List<dynamic> graphResponse= await _recoveredGraphRepository.fetchRecoveredDate();
      print(graphResponse[0]);
      recoveredGraphSink.add(ApiResponse.completed(graphResponse));
    }catch(e){
      recoveredGraphSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchRecoveredNumberGraphData()async{
    recoveredNumberGraphSink.add(ApiResponse.loading('Fetching Data'));
    try{
      // print('graph bloc');
      List<dynamic> graphResponse= await _recoveredNumberGraphRepository.fetchRecoveredDateNumber();
      print(graphResponse[0]);
      recoveredNumberGraphSink.add(ApiResponse.completed(graphResponse));
    }catch(e){
      recoveredNumberGraphSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose(){
    _casesGraphController?.close();
    _casesNumberGraphController?.close();
    _deathGraphController?.close();
    _deathNumberGraphController?.close();
    _recoveredGraphController?.close();
    _recoveredNumberGraphController?.close();

  }

}