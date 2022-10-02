import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CharacterDetailsPage extends StatefulWidget {
  final int id;
  const CharacterDetailsPage({super.key, required this.id});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  void getCharacter() async {
    http.Response res = await http.get(Uri.parse('https://www.breakingbadapi.com/api/characters/${widget.id}'));

    var data = jsonDecode(res.body);

    print(widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            child: Column(
              children: const [
                Image(
                  height: 200,
                  width: 200,
                  image: NetworkImage(
                      'https://static.wikia.nocookie.net/breakingbad/images/0/05/Season_2_-_Jesse.jpg/revision/latest?cb=20090617154632'),
                ),
                Text("Name: Jesse Pinkman"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
