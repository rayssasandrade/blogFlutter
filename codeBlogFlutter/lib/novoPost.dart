import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart' as dio;
import 'package:codeBlogFlutter/post.dart';
import 'package:codeBlogFlutter/HttpService.dart';

class NovoPost extends StatefulWidget {
 
  NovoPost({Key key}) : super(key: key);

  @override
  _NovoPosteState createState(){
    return _NovoPosteState();
  }
}

class _NovoPosteState extends State<NovoPost> {

  HttpService httpService = new  HttpService();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();

  Future<Post> _futurePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Post'),
      ),
      body: Container(
        alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futurePost == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                        controller: _tituloController,
                        decoration: InputDecoration(hintText: 'Titulo'),
                    ),
                    TextField(
                      controller: _autorController,
                      decoration: InputDecoration(hintText: 'Autor'),
                    ),
                    TextField(
                      controller: _dataController,
                      decoration:
                          InputDecoration(hintText: 'Data de Publicação'),
                    ),
                    TextField(
                      controller: _textoController,
                      decoration: InputDecoration(hintText: 'Texto'),
                    ),
                    ElevatedButton(
                      child: Text('Salvar'),
                      onPressed: () {
                        setState(() {
                          _futurePost = httpService.createPost(_tituloController.text, _autorController.text, _dataController.text, _textoController.text);
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<Post>(
                  future: _futurePost,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.titulo);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
    );
  }
}
