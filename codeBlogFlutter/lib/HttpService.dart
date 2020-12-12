import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:codeBlogFlutter/post.dart';

class HttpService {

  final String url = 'http://10.0.0.8:3000/';
  
  Future<List<Post>> getPosts() async {
    final response =
      await http.get(this.url+'posts');

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
  
  Future<Post> createPost(String titulo, String autor, String dataPublicacao, String texto) async {
      final http.Response response = await http.post(url + 'newpost', headers: {
        'Content-Type': 'application/json',
      }, 
      body: jsonEncode(<String, String>{
        "titulo": titulo,
        "autor": autor,
        "dataPublicacao": dataPublicacao,
        "texto": texto
      },),
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return Post.fromJson(jsonDecode(responseString));
    } else {
      throw Exception('Falha ao criar o post');
    }
  }

  /*
  Future<http.Response> createPost(String titulo, String autor, String dataPublicacao, String texto) {
    return http.post(this.url+'newpost',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'titulo': titulo,
        'autor': autor,
        'dataPublicacao': dataPublicacao,
        'texto': texto,
      }),
    );
    if (response.statusCode == 201) {
      return  Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao criar o post');
    }
  }

  
   
  updatePost() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"titulo": "Power BI","autor": "Felipe Santos","dataPublicacao": "05-12-2020","texto": "Venha aprender Power BI"}';
    final response = await http.get(this.url+'posts');
    Response response = await put(url+'newpost', headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
  }

  
  Future<void> deletePost(int id) async {
  final response =
      await http.delete(this.url+'$id');

    if (response.statusCode == 200) {
      print("Deletado");
    } else {
      throw "Can't delete post.";
    }
  }

  //autenticação
  Future<Album> fetchAlbum() async {
    final response = await http.get(
      'https://jsonplaceholder.typicode.com/albums/1',
      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
    );
    final responseJson = jsonDecode(response.body);

    return Album.fromJson(responseJson);
  }
  */

}