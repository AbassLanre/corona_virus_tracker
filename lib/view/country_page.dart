import 'package:corona_virus_tracker/blocs/country_bloc.dart';
import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/networking/api_response_to_ui.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final String countryName;

  CountryPage({this.countryName});

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  CountryBloc _countryBloc;

  @override
  void initState() {
    super.initState();
    _countryBloc = CountryBloc(widget.countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            return _countryBloc.fetchCountryDetails(widget.countryName);
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
                    return CountryData();
                    break;
                  case Status.ERROR:
                    return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () {
                          _countryBloc.fetchCountryDetails(widget.countryName);
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

class CountryData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xF5F5F5F5),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                StackPart(),
          ]),
        ),
      ),
    );
  }
}

class StackPart extends StatelessWidget {
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
                  '',
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
                  children: [],
                ),
              ),
            ),
          ),
        ),
      ],
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
