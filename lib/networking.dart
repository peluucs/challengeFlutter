import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}

class User {
  final String username;
  final String email;

  User({required this.username, required this.email});
}

Future<List<Post>> getPosts() async {
  http.Response response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );
  if (response.statusCode == 200) {
    final decodedPosts = jsonDecode(response.body);
    List<Post> posts = [];

    for (dynamic post in decodedPosts) {
      Post newPost = Post(
          userId: post['userId'],
          id: post['id'],
          title: post['title'],
          body: post['body']);
      posts.add(newPost);
    }

    return posts;
  } else {
    print(response.statusCode);
    return [];
  }
}

Future<User> getUser(int idUser) async {
  http.Response response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/users/$idUser'),
  );
  if (response.statusCode == 200) {
    final decodedUser = jsonDecode(response.body);
    return User(username: decodedUser['username'], email: decodedUser['email']);
  } else {
    print(response.statusCode);
    throw 'ERROR';
  }
}
