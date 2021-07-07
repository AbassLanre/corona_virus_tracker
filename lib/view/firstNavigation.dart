import 'package:corona_virus_tracker/models/corona_response.dart';
import 'package:corona_virus_tracker/models/reuseable_floating_action_button.dart';
import 'package:corona_virus_tracker/view/add_country_page.dart';
import 'package:corona_virus_tracker/view/country_page.dart';
import 'package:corona_virus_tracker/view/secondNavigation.dart';
import 'package:corona_virus_tracker/view/thirdNavigation.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

///////////////vvm dagger retrofit

int _selectedIndex = 0;


const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

List countriesToBeDisplayed = ['Nigeria'];

class FirstNavigation extends StatefulWidget {
  final CountryResponse countryResponse;
  final AllResponse allResponse;
  final List countryListResponse;
  final List flagResponse;
  final List caseGraph;
  final List caseNumberGraph;
  final List deathGraph;
  final List deathNumberGraph;
  final List recoveredGraph;
  final List recoveredNumber;
  final String countryToBeDisplayed;

  FirstNavigation(
      {this.countryResponse,
      this.allResponse,
      this.countryListResponse,
      this.flagResponse,
      this.countryToBeDisplayed,
      this.caseGraph,
      this.caseNumberGraph,
      this.deathGraph,
      this.deathNumberGraph,
      this.recoveredGraph,
      this.recoveredNumber});

  @override
  _FirstNavigationState createState() => _FirstNavigationState();
}

class _FirstNavigationState extends State<FirstNavigation> {
  List caseNumber;
  List deathNumber;
  List recoveredNumber;
  List caseGraphGraph;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  updateCountriesToBeDisplayed(String country) {
    countriesToBeDisplayed.add(country);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.countryToBeDisplayed != null) {
      updateCountriesToBeDisplayed(widget.countryToBeDisplayed);
      caseNumber = widget.caseNumberGraph.cast<double>();
      deathNumber = widget.deathNumberGraph.cast<double>();
      recoveredNumber = widget.recoveredNumber.cast<double>();
      caseGraphGraph = widget.caseGraph.cast<String>();
    }

  }

  /////////// use a future to build so everything loads first

  @override
  Widget build(BuildContext context) {
    List<FlSpot> caseGraphh =caseNumber;
    List<FlSpot> casedeathh =deathNumber;
    List<FlSpot> caseRecoveredd =recoveredNumber;

    // try {
    //   print('nowwww  ${caseGraphGraph[0]}');
    // }catch(e){print('eron');}
    // final List<Feature> features =[
    //   Feature(
    //     title: 'Cases' ,
    //     color: Colors.blue,
    //     data: caseNumber,
    //   ),
    //   Feature(
    //     title: 'Death' ,
    //     color: Colors.red,
    //     data:deathNumber,
    //   ),
    //   Feature(
    //     title: 'Recovered' ,
    //     color: Colors.green,
    //     data: recoveredNumber,
    //   ),
    // ];
    List<Widget> _widgetOptions = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .15,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFF5AC7AA),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 10.0, bottom: 20.0),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 20,
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 2, left: 10.0),
            child: Text(
              'Confirmed Cases',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 7, left: 10.0),
            child: Text(
              'Last Updated on 31/03/2020, 8:00 AM',
              style: TextStyle(
                fontSize: 15.0,
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
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 8.0),
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
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, left: 8.0),
                              child: Text(
                                widget.countryResponse.deaths.toString(),
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
          // LineGraph(
          //     features: features, size: size)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
                child: RoundFloatingActionButton(
              icon: Icons.add,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddCountryPage(
                            flag: widget.flagResponse,
                            countryList: widget.countryListResponse)));
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 390,
              width: 400,
              child: Text('dd'),
            ),
          )

        ],
      ),
      SecondNavigation(),
      ThirdNavigation(),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        selectedItemColor: Color(0xFF5AC7AA),
        onTap: _onItemTapped,
      ),
    );
  }
}


// LineGraph(
// features: features,
// size: Size(300, 290),
// labelX: ['0', '1', '2'],
// labelY: ["45M", "90M","135M","200M"],
// showDescription: true,
// graphColor: Colors.black54,
// )