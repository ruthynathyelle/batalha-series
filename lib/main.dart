import 'package:flutter/material.dart';
import 'package:batalha_series/View/home_Page.dart';

void main() {
  runApp(BatalhaDeSeriesApp());
}

class BatalhaDeSeriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Batalha de Séries',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
      
    );
  }
}
