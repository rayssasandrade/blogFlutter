import 'package:codeBlogFlutter/service/HttpService.dart';
import 'package:flutter/material.dart';
import 'package:codeBlogFlutter/model/post.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class NovoPost extends StatefulWidget {
  
  Post post;

  NovoPost({this.post});

  @override
  _NovoPostState createState() => _NovoPostState();
}

class _NovoPostState extends State<NovoPost> {
  bool _isLoading = false;
  HttpService _httpService = HttpService();
  bool _isFieldTituloValid;
  bool _isFieldAutorValid;
  bool _isFieldDataPublicacaoValid;
  bool _isFieldTextoValid;
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerAutor = TextEditingController();
  TextEditingController _controllerDataPublicacao = TextEditingController();
  TextEditingController _controllerTexto = TextEditingController();

  @override
  void initState() {
    if (widget.post != null) {
      _isFieldTituloValid = true;
      _controllerTitulo.text = widget.post.titulo;

      _isFieldAutorValid = true;
      _controllerAutor.text = widget.post.autor;

      _isFieldDataPublicacaoValid = true;
      _controllerDataPublicacao.text = widget.post.dataPublicacao;

      _isFieldTextoValid = true;
      _controllerTexto.text = widget.post.texto;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.post == null ? "Criar Post" : "Editar Post",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldTitulo(),
                _buildTextFieldAutor(),
                _buildDateFieldDataPublicacao(),
                _buildTextFieldTexto(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.post == null
                          ? "Salvar".toUpperCase()
                          : "Atualizar".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldTituloValid == null ||
                          _isFieldAutorValid == null ||
                          _isFieldDataPublicacaoValid == null ||
                          _isFieldTextoValid == null ||
                          !_isFieldTituloValid ||
                          !_isFieldAutorValid ||
                          !_isFieldDataPublicacaoValid ||
                          !_isFieldTextoValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }

                      setState(() => _isLoading = true);

                      String titulo = _controllerTitulo.text.toString();
                      String autor = _controllerAutor.text.toString();
                      String dataPublicacao =
                          _controllerDataPublicacao.text.toString();
                      String texto = _controllerTexto.text.toString();

                      Post post = Post(
                          titulo: titulo,
                          autor: autor,
                          dataPublicacao: dataPublicacao,
                          texto: texto);
                      if (widget.post == null) {
                        _httpService.createPost(post).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Erro ao salvar post."),
                            ));
                          }
                        });
                      } else {
                        post.id = widget.post.id;
                        _httpService.updatePost(post).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Erro ao atualizar post."),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.deepPurple[300],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldTitulo() {
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Titulo do post",
        errorText: _isFieldTituloValid == null || _isFieldTituloValid
            ? null
            : "Titulo do post é requerido",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTituloValid) {
          setState(() => _isFieldTituloValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAutor() {
    return TextField(
      controller: _controllerAutor,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Autor",
        errorText: _isFieldAutorValid == null || _isFieldAutorValid
            ? null
            : "Autor e requerido",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAutorValid) {
          setState(() => _isFieldAutorValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildDateFieldDataPublicacao() {
    return TextField(
      controller: _controllerDataPublicacao,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Data de publicacao",
        errorText:
            _isFieldDataPublicacaoValid == null || _isFieldDataPublicacaoValid
                ? null
                : "Data de publicacao e requerida",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDataPublicacaoValid) {
          setState(() => _isFieldDataPublicacaoValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTexto() {
    return TextField(
      controller: _controllerTexto,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Texto da publicacao",
        errorText: _isFieldTextoValid == null || _isFieldTextoValid
            ? null
            : "Texto do post é requerido",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTextoValid) {
          setState(() => _isFieldTextoValid = isFieldValid);
        }
      },
    );
  }
}
