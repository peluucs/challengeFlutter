import 'dart:convert';

import 'package:http/http.dart' as http;

void main() => getData();

Future getData() async {
  http.Response response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );
  if (response.statusCode == 200) {
    final post = jsonDecode(response.body);

    return print(post);
  } else {
    print(response.statusCode);
  }
}
