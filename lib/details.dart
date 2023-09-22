import 'package:challenge_flutter/networking.dart';
import 'package:flutter/material.dart';

String capitalizeFirstWord(String text) {
  List<String> words = text.split(' ');
  if (words.isNotEmpty) {
    words[0] = words[0][0].toUpperCase() + words[0].substring(1);
  }
  return words.join(' ');
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;
    getUser(post.userId);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 249, 199, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        title: Text('Detalhes do Post'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              capitalizeFirstWord(post.title), // Capitaliza o título
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              capitalizeFirstWord(post.body), // Capitaliza o corpo do texto
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          SizedBox(height: 10),
          FutureBuilder<User>(
            future: getUser(post.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
                //Loading
              } else if (snapshot.hasError) {
                return Center(child: Text('Error'));
                //Erro
              } else {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      alignment: AlignmentDirectional.topStart,
                      child: Text('Autor: ${snapshot.data!.username}'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      alignment: AlignmentDirectional.topStart,
                      child: Text('Email: ${snapshot.data!.email}'),
                    ),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
