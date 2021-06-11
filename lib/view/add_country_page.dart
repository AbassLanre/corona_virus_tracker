import 'package:flutter/material.dart';

class AddCountryPage extends StatefulWidget {
  final List flag;
  final List countryList;

  AddCountryPage({this.countryList, this.flag});

  @override
  _AddCountryPageState createState() => _AddCountryPageState();
}

class _AddCountryPageState extends State<AddCountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
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
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: ()=> Navigator.pop(context),
                                child: Icon(Icons.arrow_back)),
                            SizedBox(width: 50,),
                            Text(
                              'Add Country',
                            ),
                          ],
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
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.countryList.length,
                itemBuilder: (_,position){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(widget.flag[position]),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(widget.countryList[position]),
                  );
                })
          ],
        ),
      ),
    );
  }
}
