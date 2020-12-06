import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:codeBlogFlutter/post.dart';

class HttpService {

  final String url = 'http://10.0.0.9:9090/';
  
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
  /* 
  Future<void> deletePost(int id) async {
  final response =
      await http.delete(this.url+'$id');

    if (response.statusCode == 200) {
      print("Deletado");
    } else {
      throw "Can't delete post.";
    }
  }
  */

}