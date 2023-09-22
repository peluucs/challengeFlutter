import 'package:challenge_flutter/networking.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Detalhes do Post'),
      ),
      body: Center(
        child: Text(post.body),
      ),
    );
  }
}
