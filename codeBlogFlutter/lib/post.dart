class Post {
  int id;
  String titulo;
  String autor;
  String dataPublicacao;
  String texto;

  Post({this.id, this.titulo, this.autor, this.dataPublicacao, this.texto});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    autor = json['autor'];
    dataPublicacao = json['dataPublicacao'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['autor'] = this.autor;
    data['dataPublicacao'] = this.dataPublicacao;
    data['texto'] = this.texto;
    return data;
  }

  String toString(){
    return "${this.titulo} ${this.autor} ${this.dataPublicacao} ${this.texto}";
  }

}