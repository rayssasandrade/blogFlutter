import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:codeBlogFlutter/app.dart';
import 'package:codeBlogFlutter/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:codeBlogFlutter/service/HttpService.dart';
import 'package:codeBlogFlutter/form/novoUsuario.dart';

import 'alert.dart';

class Login extends StatelessWidget{

  HttpService httpService = new  HttpService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text('Login'),
        ),
      ),
      body: _body (context),
    );
  }

  _body(BuildContext context){
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              _textFormField(
                "Email",
                "Digite seu email",
                controller: _emailController,
                validator: _validaEmail
              ),
              _textFormField(
                "Senha",
                "Digite sua senha",
                controller: _senhaController,
                validator: _validaSenha
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  _clickButton(context);
                },
              ),
              ElevatedButton(
                child: Text('Cadastro'),
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NovoUsuario()),
                  );
                },
              ),
            ],
          ),
        ),
      );
  }

  _textFormField(
    String label,
    String hint, {
      bool senha = true,
      TextEditingController controller,
      FormFieldValidator<String> validator,
    }
  ) {
      return TextFormField(
        controller: controller,
        validator: validator,
        obscureText: senha,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      );
    }
  
  String _validaEmail(String texto){
    if(texto.isEmpty){
      return "Digite o email";
    }
    return null;
  }

  String _validaSenha(String texto){
    if(texto.isEmpty){
      return "Digite a senha";
    }
    return null;
  }

  Future<void> _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();

    if(!formOk){
      return;
    }

    String email = _emailController.text;
    String senha = _senhaController.text;

    print("Login: $email senha: $senha");

    var user = await httpService.login(email, senha);
    if(user!=null){
      _navegaHomePage(context);
    } else {
      alert(context, "Login inválido!");
    }

  }

  _navegaHomePage(BuildContext context){
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => App()),
      );
  }

}