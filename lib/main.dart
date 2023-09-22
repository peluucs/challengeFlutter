import 'package:challenge_flutter/details.dart';
import 'package:challenge_flutter/networking.dart';
import 'package:flutter/material.dart';

void main() => getUser(1); //runApp(MyApp());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            //Loading
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
            //Erro
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Vazio'));
            //Empty
          } else {
            print(snapshot.data!);
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: snapshot.data![index]);
                  },
                  title: Text(snapshot.data![index].title),
                  //return Text(snapshot.data![1].title);
                );
              },
            );
          }
        },
      ),
    );
  }
}
