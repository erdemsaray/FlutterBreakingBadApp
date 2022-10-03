import 'dart:convert';
import 'package:breakingbadapp/models/character.dart';
import 'package:breakingbadapp/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_fade/image_fade.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int id;
  const CharacterDetailsPage({super.key, required this.id});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  Character k = Character();
  bool yukleniyor = false;
  late http.Response res;

  void getCharacter() async {
    if (widget.id == -1) {
      res = await http.get(Uri.parse('https://www.breakingbadapi.com/api/character/random'));
    } else {
      res = await http.get(Uri.parse('https://www.breakingbadapi.com/api/characters/${widget.id}'));
    }

    var data = jsonDecode(res.body);

    setState(() {
      k.name = data[0]['name'] ?? 'Unknown';
      k.birthDate = data[0]['birthday'] ?? 'Unknown';
      k.actor = data[0]['portrayed'] ?? 'Unknown';
      k.status = data[0]['status'] ?? 'Unknown';
      k.img = data[0]['img'] ?? 'Unknown';
      yukleniyor = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return yukleniyor == false
        ? const Scaffold(
            body: Center(
              child: SpinKitDoubleBounce(
                color: Colors.indigo,
                size: 150.0,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 104, 142, 192),
            appBar: AppBar(
              title: AnimatedTextKit(
                animatedTexts: [WavyAnimatedText(k.name)],
                repeatForever: true,
              ),
            ),
            body: DefaultTextStyle(
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ImageFade(
                      height: 200,
                      fit: BoxFit.cover,
                      image: NetworkImage(k.img),
                      duration: const Duration(seconds: 2),
                      //curve: Curves.bounceInOut,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                    width: 250.0,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  CustomCard(title: 'Name:', value: k.name),
                  CustomCard(title: 'Actor:', value: k.actor),
                  CustomCard(title: 'BirthDate:', value: k.birthDate),
                  CustomCard(title: 'Status:', value: k.status),
                ],
              ),
            ),
          );
  }
}
