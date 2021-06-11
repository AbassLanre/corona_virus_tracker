import 'package:corona_virus_tracker/blocs/all_bloc.dart';
import 'package:corona_virus_tracker/blocs/country_bloc.dart';
import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/models/reuseable_floating_action_button.dart';
import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:corona_virus_tracker/view/country_page.dart';
import 'package:corona_virus_tracker/view/emergency_page.dart';
import 'package:corona_virus_tracker/view/news_page.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 0;
const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


List countriesToBeDisplayed = [
  'New Zealand',
  'Nigeria',
  'Ghana',
  'Egypt',
  'Italy',
  'Korea',
];

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CountryBloc _countryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countryBloc = CountryBloc('Nigeria');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            return _countryBloc.fetchCountryDetails("Nigeria");
          },
          child: StreamBuilder<ApiResponse<CountryResponse>>(
            stream: _countryBloc.countryStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return DashboardData(countryCoronaDetails: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () {
                          _countryBloc.fetchCountryDetails('Nigeria');
                        });
                    break;
                }
              }
              return Container();
            },
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _countryBloc.dispose();
    super.dispose();

  }
}



class StackPart extends StatefulWidget {

  @override
  _StackPartState createState() => _StackPartState();
}

class _StackPartState extends State<StackPart> {
  AllDataBloc _allDataBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allDataBloc = AllDataBloc();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            return _allDataBloc.fetchAllCountryData();
          },
          child: StreamBuilder<ApiResponse<AllResponse>>(
            stream: _allDataBloc.allStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return StackPartData(allResponse: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () {
                          _allDataBloc.fetchAllCountryData();
                        });
                    break;
                }
              }
              return Container();
            },
          )),
    );
  }
}

class StackPartData extends StatefulWidget {
  final AllResponse allResponse;
  StackPartData({this.allResponse});
  @override
  _StackPartDataState createState() => _StackPartDataState();
}

class _StackPartDataState extends State<StackPartData> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width,
              color: Colors.greenAccent,
              child: Padding(
                padding:
                const EdgeInsets.only(top: 30.0, left: 10.0, bottom: 20.0),
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .10,
            right: 10.0,
            left: 10.0,
          ),
          child: Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.info,
                            size: 12,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Globally',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Total Confirmed',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              )),
                          Expanded(
                              child: Text(
                                widget.allResponse.totalCases.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Total Deaths',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              )),
                          Expanded(
                              child: Text(
                                widget.allResponse.totalDeaths.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Total Recovered',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              )),
                          Expanded(
                              child: Text(
                                widget.allResponse.totalRecovered.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DashboardData extends StatefulWidget {
  final CountryResponse countryCoronaDetails;
  DashboardData({this.countryCoronaDetails});
  @override
  _DashboardDataState createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  int _cases;
  int _death;
  int _recovered;

    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    List<Widget> _widgetOptions = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StackPart(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 2, left: 10.0),
            child: Text(
              'Confirmed Cases',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10.0),
            child: Text(
              'Last Updated on 31/03/2020, 8:00 AM',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: countriesToBeDisplayed.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CountryPage(
                            countryName: countriesToBeDisplayed[index],
                          )));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Colors.grey,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                countriesToBeDisplayed[index],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                              child: Text(
                                widget.countryCoronaDetails.deaths.toString(),
                                style: TextStyle(
                                    fontSize: 27.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
                child: RoundFloatingActionButton(
                  icon: Icons.add,
                  onPressed: () {},
                )),
          )
        ],
      ),
      NewsPage(),
      EmergencyPage(),
    ];

    /////////////////////////////////////////////////////////////////////////////////////////////////////

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xF5F5F5F5),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _widgetOptions.elementAt(_selectedIndex),
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Emergency',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loadingMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            RaisedButton(
              color: Colors.redAccent,
              child: Text(
                'Retry',
              ),
              onPressed: onRetryPressed,
            )
          ],
        ),
      ),
    );
  }
}
