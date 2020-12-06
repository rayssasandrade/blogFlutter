import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:codeBlogFlutter/post.dart';
import 'package:codeBlogFlutter/HttpService.dart';

class PostDetalhes extends StatelessWidget {
  
  final Post post;

  PostDetalhes({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post.titulo),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Titulo"),
                        subtitle: Text(post.titulo),
                      ),
                      ListTile(
                        title: Text("Autor"),
                        subtitle: Text(post.autor),
                      ),
                      ListTile(
                        title: Text("Data de publicação"),
                        subtitle: Text(post.dataPublicacao),
                      ),
                      ListTile(
                        subtitle: Text(post.texto),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}