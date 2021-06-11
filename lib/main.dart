import 'package:corona_virus_tracker/view/dashboard2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Corona Tracker',
    theme: ThemeData(
      primaryColor: Color(0xFF5AC7AA),
    ),
    debugShowCheckedModeBanner: false,
    home: DashBoard2(),
  ));
}