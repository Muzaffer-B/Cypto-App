import 'dart:convert';


import 'package:crypto_currency/scrrens/home_screen.dart';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'helper/LoadData.dart';

void main()=> runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home_screen(),
    );
  }
}

