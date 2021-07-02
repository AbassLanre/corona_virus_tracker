import 'package:corona_virus_tracker/blocs/all_bloc.dart';
import 'package:corona_virus_tracker/blocs/all_graph_bloc.dart';
import 'package:corona_virus_tracker/blocs/country_bloc.dart';
import 'package:corona_virus_tracker/blocs/country_list_bloc.dart';
import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:corona_virus_tracker/view/firstNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

////////////////////////////////////////////////////////////////////////////////
class DashBoard2 extends StatefulWidget {
  @override
  _DashBoard2State createState() => _DashBoard2State();
}

class _DashBoard2State extends State<DashBoard2> {
  CountryBloc _countryBloc;
  AllDataBloc _allDataBloc;
  GraphDataBloc _graphDataBloc;
  CountryListDataBloc _countryListDataBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allDataBloc = AllDataBloc();
    _countryBloc = CountryBloc('Nigeria');
    _countryListDataBloc = CountryListDataBloc();
    _graphDataBloc = GraphDataBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            List blocs = [
              _countryBloc.fetchCountryDetails("Nigeria"),
              _allDataBloc.fetchAllCountryData(),
              _countryListDataBloc.fetchCountryListData(),
              _countryListDataBloc.fetchFlagListData(),
              _graphDataBloc.fetchCasesGraphData(),
              _graphDataBloc.fetchCasesNumberGraphData(),
              _graphDataBloc.fetchDeathGraphData(),
              _graphDataBloc.fetchDeathNumberGraphData(),
              _graphDataBloc.fetchRecoveredGraphData(),
              _graphDataBloc.fetchRecoveredNumberGraphData(),
            ];
            return blocs;
          },
          child: StreamBuilder<ApiResponse<CountryResponse>>(
            stream: _countryBloc.countryStream,
            builder: (_, snapshot) {
              return StreamBuilder(
                  stream: _allDataBloc.allStream,
                  builder: (_, snapshot2) {
                    return StreamBuilder(
                        stream: _countryListDataBloc.listStream,
                        builder: (_, snapshot3) {
                          return StreamBuilder(
                              stream: _countryListDataBloc.flagStream,
                              builder: (_, snapshot4) {
                                return StreamBuilder(
                                    stream: _graphDataBloc.caseGraphStream,
                                    builder: (_, snapshot5) {
                                      return StreamBuilder(
                                          stream: _graphDataBloc
                                              .caseNumberGraphStream,
                                          builder: (_, snapshot6) {
                                            return StreamBuilder(
                                                stream: _graphDataBloc
                                                    .deathGraphStream,
                                                builder: (_, snapshot7) {
                                                  return StreamBuilder(
                                                      stream: _graphDataBloc
                                                          .deathNumberGraphStream,
                                                      builder: (_, snapshot8) {
                                                        return StreamBuilder(
                                                            stream: _graphDataBloc
                                                                .recoveredGraphStream,
                                                            builder:
                                                                (_, snapshot9) {
                                                              return StreamBuilder(
                                                                  stream: _graphDataBloc
                                                                      .recoveredNumberGraphStream,
                                                                  builder: (_,
                                                                      snapshot10) {
                                                                    if (snapshot.hasData &&
                                                                        snapshot2
                                                                            .hasData &&
                                                                        snapshot3
                                                                            .hasData &&
                                                                        snapshot4
                                                                            .hasData &&
                                                                        snapshot5
                                                                            .hasData &&
                                                                        snapshot6
                                                                            .hasData &&
                                                                        snapshot7
                                                                            .hasData &&
                                                                        snapshot8
                                                                            .hasData &&
                                                                        snapshot9
                                                                            .hasData &&
                                                                        snapshot10
                                                                            .hasData) {
                                                                      switch (snapshot
                                                                          .data
                                                                          .status) {
                                                                        case Status
                                                                            .LOADING:
                                                                          return Loading(
                                                                              loadingMessage: snapshot.data.message);
                                                                          break;
                                                                        case Status
                                                                            .COMPLETED:
                                                                          return FirstNavigation(
                                                                            countryResponse:
                                                                                snapshot.data.data,
                                                                            allResponse:
                                                                                snapshot2.data.data,
                                                                            countryListResponse:
                                                                                snapshot3.data.data,
                                                                            flagResponse:
                                                                                snapshot4.data.data,
                                                                            caseGraph:
                                                                                snapshot5.data.data,
                                                                            caseNumberGraph:
                                                                                snapshot6.data.data,
                                                                            deathGraph:
                                                                                snapshot7.data.data,
                                                                            deathNumberGraph:
                                                                                snapshot8.data.data,
                                                                            recoveredGraph:
                                                                                snapshot9.data.data,
                                                                            recoveredNumber:
                                                                                snapshot10.data.data,
                                                                          );
                                                                          break;
                                                                        case Status
                                                                            .ERROR:
                                                                          return Error(
                                                                              errorMessage: snapshot.data.message,
                                                                              onRetryPressed: () {
                                                                                _countryBloc.fetchCountryDetails('Nigeria');
                                                                              });
                                                                          break;
                                                                      }
                                                                    }
                                                                    return Container();
                                                                  });
                                                            });
                                                      });
                                                });
                                          });
                                    });
                              });
                        });
                  });
            },
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _countryBloc.dispose();
    _allDataBloc.dispose();
    super.dispose();
  }
}
////////////////////////////////////////////////////////////////////////////////

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
