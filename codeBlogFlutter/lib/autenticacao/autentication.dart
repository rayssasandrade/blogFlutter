import 'dart:async';
import 'package:codeBlogFlutter/autenticacao/login.dart';
import 'package:codeBlogFlutter/form/novoPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:codeBlogFlutter/service/HttpService.dart';

class Autentication extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AutenticationState();
}

class _AutenticationState extends State<Autentication> {

  HttpService httpService = new  HttpService();
  var futureToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text("Autenticação")
        ),
      ),
      body: FutureBuilder(
//        future: httpService.getToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            String token = snapshot.data;
            if(token!=""){
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;
  }
  
}