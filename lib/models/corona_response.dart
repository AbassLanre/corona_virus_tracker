

class AllResponse{

  AllResponse({this.totalCases, this.totalRecovered, this.totalDeaths});

  int totalDeaths;
  int totalRecovered;
  int totalCases;

  AllResponse.fromJson(Map<String, dynamic> jsonData){
    totalDeaths=jsonData['deaths'];
    totalRecovered=jsonData['recovered'];
    totalCases= jsonData['cases'];

  }
}

class CountryResponse{

  CountryResponse({this.cases, this.deaths, this.flag, this.recovered});

  int cases;
  int deaths;
  int recovered;
  String flag;

  CountryResponse.fromJson(Map<String, dynamic> jsonData){
    cases=jsonData['cases'];
    deaths=jsonData['deaths'];
    recovered= jsonData['recovered'];
    flag = jsonData['countryInfo']['flag'];
  }
}

class CountryListResponse{
  CountryListResponse({this.countryList ,this.flagList});

  List<dynamic> flagList;
  List<dynamic> countryList;

  CountryListResponse.fromJson(List<dynamic> jsonData){
    if(jsonData !=null){
      flagList = [];
      jsonData.forEach((v){
        flagList.add(v['countryInfo']['flag']);
      });
    }
    if(jsonData !=null){
      countryList = [];
      jsonData.forEach((v){
        countryList.add(v['country']);
      });
    }

  }
}

class Country{
  String flag;
  String countryList;
  Country({this.flag, this.countryList});

  Country.fromJson(Map<String, dynamic> jsonData){
    flag = jsonData['countryInfo']['flag'];
    countryList = jsonData['country'];
  }
}

// class GraphResponse{
//   GraphResponse();
//
// }