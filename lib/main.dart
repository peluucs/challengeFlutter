import 'package:challenge_flutter/details.dart';
import 'package:challenge_flutter/networking.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {'/details': (context) => Details()},
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = getPosts();
  }

  String capitalizeFirstWord(String text) {
    List<String> words = text.split(' ');
    if (words.isNotEmpty) {
      words[0] = words[0][0].toUpperCase() + words[0].substring(1);
    }
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 249, 199, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Vazio'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 1.0,
                    indent: 16.0,
                    endIndent: 16.0,
                  );
                } else {
                  final itemIndex = index ~/ 2;
                  final title =
                      capitalizeFirstWord(snapshot.data![itemIndex].title);
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/details',
                          arguments: snapshot.data![itemIndex]);
                    },
                    title: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
