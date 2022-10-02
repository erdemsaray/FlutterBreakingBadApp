import 'dart:convert';

import 'package:breakingbadapp/screens/character_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<Character> characterList = [];

  void getCharacters() async {
    http.Response res = await http.get(Uri.parse('https://www.breakingbadapi.com/api/characters'));

    var data = await jsonDecode(res.body);

    setState(() {
      for (var i = 0; i < data.length; i++) {
        if (i != 12 && i != 13) {
          //api kaynaginda sıkıntı oldugu icin bu elemanlari atlamak zorunda kaldim.
          Character k = Character();
          k.id = data[i]['char_id'];
          k.name = data[i]['name'];
          k.birthDate = data[i]['birthday'];
          k.img = data[i]['img'];
          k.actor = data[i]['portrayed'];
          k.status = data[i]['status'];

          characterList.add(k);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Karakter Listesi"),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Theme.of(context).backgroundColor, Theme.of(context).scaffoldBackgroundColor],
                  tileMode: TileMode.mirror)),
          child: ListView.builder(
              itemCount: characterList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CharacterDetailsPage(
                                  id: characterList[index].id,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      characterList[index].name,
                      style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 20.0),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(characterList[index].img),
                    ),
                  ),
                );
              })),
    );
  }
}
