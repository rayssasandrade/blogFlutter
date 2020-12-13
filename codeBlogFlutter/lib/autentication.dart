import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:codeBlogFlutter/login.dart';
import 'package:codeBlogFlutter/novoPost.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart' as dio;
import 'package:codeBlogFlutter/post.dart';
import 'package:codeBlogFlutter/HttpService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Autentication extends StatefulWidget {

  Autentication({Key key}) : super(key: key);

  @override
  _AutenticationState createState() => _AutenticationState();
}

class _AutenticationState extends State<Autentication> {

  HttpService httpService = new  HttpService();
  Future<String> futureToken;

  @override
  initState() async {
    futureToken = (await getToken()) as Future<String>;
  }

  @override
  Widget build(BuildContext context) {
    if(futureToken != null){
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NovoPost(),
          ),
      );
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
      );
    }
  }

  Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenjwt") ?? "");

    if (token != "") {
      print("token jwt : $token");
      return token;
    }
    return "";
  }
  
}