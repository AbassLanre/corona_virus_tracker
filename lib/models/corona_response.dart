

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

// class GraphResponse{
//   GraphResponse();
//
// }