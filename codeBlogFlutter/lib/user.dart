class User {
  int id;
  String nome;
  String perfil;
  String email;
  String password;
  String token;

  User(
      {this.id, this.nome, this.perfil, this.email, this.password, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    perfil = json['perfil'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['perfil'] = this.perfil;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }

  String toString(){
    return "${this.nome} ${this.perfil} ${this.email} ${this.token}";
  }


}