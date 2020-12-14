import 'dart:async';
import 'package:codeBlogFlutter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:codeBlogFlutter/service/HttpService.dart';

class NovoUsuario extends StatefulWidget {
 
  NovoUsuario({Key key}) : super(key: key);

  @override
  _NovoUsuarioState createState(){
    return _NovoUsuarioState();
  }
}

class _NovoUsuarioState extends State<NovoUsuario> {

  HttpService httpService = new  HttpService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _perfilController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<User> _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Usuário'),
      ),
      body: Container(
        alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureUser == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                        controller: _nomeController,
                        decoration: InputDecoration(hintText: 'Nome'),
                    ),
                    TextField(
                      controller: _perfilController,
                      decoration: InputDecoration(hintText: 'Perfil'),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration:
                          InputDecoration(hintText: 'Email'),
                    ),
                    TextField(
                      controller: _senhaController,
                      decoration: InputDecoration(hintText: 'Senha'),
                    ),
                    ElevatedButton(
                      child: Text('Salvar'),
                      onPressed: () {
                        setState(() {
                          _futureUser = httpService.createUser(_nomeController.text, _perfilController.text, _emailController.text, _senhaController.text);
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<User>(
                  future: _futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.nome);
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
