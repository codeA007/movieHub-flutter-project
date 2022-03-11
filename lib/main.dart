import 'package:flutter/material.dart';
import 'package:moviehub/screens/homePage.dart';
import 'package:moviehub/screens/linkFetcher.dart';

void main(){
  runApp(
    MaterialApp(
      home:HomePage() ,
      theme: ThemeData(
        primaryColor:const Color(0XFF11191F)
      ),
    )
  );
}

