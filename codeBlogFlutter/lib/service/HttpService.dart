import 'dart:convert';
import 'package:codeBlogFlutter/model/post.dart';
import 'package:codeBlogFlutter/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show Client;

class HttpService {
  final String baseUrl = "http://10.0.0.8:3000";
  final String baseUrlV1 = "http://10.0.0.8:3000/v1";

  Client client = Client();

  Future<List<Post>> getPosts() async {
    final response = await client.get("$baseUrl/posts");
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createPost(Post data) async {
    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenjwt") ?? "");

    final response = await client.post(
      "$baseUrlV1/newpost",
      headers: {"content-type": "application/json", 'Authorization': 'Bearer $token'},
      body: postToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePost(Post data) async {
    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenjwt") ?? "");

    final response = await client.put(
      "$baseUrlV1/${data.id}/updatepost",
      headers: {"content-type": "application/json", 'Authorization': 'Bearer $token'},
      body: postToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePost(int id) async {
    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenjwt") ?? "");

    final response = await client.delete(
      "$baseUrlV1/$id/deletepost",
      headers: {"content-type": "application/json", 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> createUser(
      String nome, String perfil, String email, String password) async {
    
    final response = await client.post(
      '$baseUrl/user',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "nome": nome,
          "perfil": perfil,
          "email": email,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return User.fromJson(jsonDecode(responseString));
    } else {
      throw Exception('Falha ao criar usuário');
    }
  }

  Future<User> login(String email, String senha) async {
    Map params = {"password": senha, "email": email};

    var user;
    var prefs = await SharedPreferences.getInstance();

    var _body = json.encode(params); 

    var response = await client.post('$baseUrl/login', headers: {
    'Content-Type': 'application/json'}, body: _body);

    Map mapResponse = json.decode(response.body);

    if(response.statusCode == 200){
      user = User.fromJson(mapResponse);
      prefs.setString("tokenjwt", mapResponse["token"]);
    }else{
      user = null;
    }
    return user;
  }

}
