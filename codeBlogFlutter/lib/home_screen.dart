import 'package:flutter/material.dart';
import 'package:codeBlogFlutter/service/HttpService.dart';
import 'package:codeBlogFlutter/model/post.dart';
import 'package:codeBlogFlutter/form/novoPost.dart';
import 'package:codeBlogFlutter/form/postDetalhes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  HttpService httpService;

  @override
  void initState() {
    super.initState();
    httpService = HttpService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Ops, algo de errado aconteceu: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Post> posts = snapshot.data;
            return _buildListView(posts);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Post> posts) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Post post = posts[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.titulo,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(post.autor),
                    Text(post.dataPublicacao),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostDetalhes(
                                post: posts[index]
                              ),
                            ),
                          ),
                          child: Text(
                            "visualizar",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Alerta"),
                                    content: Text(
                                        "Voce deseja mesmo apagar o post ${post.titulo}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("sim"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          httpService
                                              .deletePost(post.id)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Post removido com sucesso")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Erro ao remover post")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("não"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "remover",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var result = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NovoPost(post: post);
                            }));
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: Text(
                            "editar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: posts.length,
      ),
    );
  }
}
