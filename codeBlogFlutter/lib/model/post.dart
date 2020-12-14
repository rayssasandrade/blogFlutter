import 'dart:convert';

class Post {
  int id;
  String titulo;
  String autor;
  String dataPublicacao;
  String texto;

  Post({this.id = 0, this.titulo, this.autor, this.dataPublicacao, this.texto});

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
        id: map["id"],
        titulo: map["titulo"],
        autor: map["autor"],
        dataPublicacao: map["dataPublicacao"],
        texto: map["texto"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titulo": titulo,
      "autor": autor,
      "dataPublicacao": dataPublicacao,
      "texto": texto
    };
  }

  @override
  String toString() {
    return 'Post{id: $id, titulo: $titulo, autor: $autor, dataPublicacao: $dataPublicacao, texto: $texto}';
  }
}

List<Post> postFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Post>.from(data.map((item) => Post.fromJson(item)));
}

String postToJson(Post data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
