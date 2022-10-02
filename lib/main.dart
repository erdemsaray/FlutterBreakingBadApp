import 'package:breakingbadapp/screens/character_details.dart';
import 'package:breakingbadapp/screens/character_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Breaking Bad',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF67e6dc),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: const Color(0xFFeb4d4b)),
          secondaryHeaderColor: const Color(0xFF222f3e),
          backgroundColor: const Color(0xFFfc5c65),
        ),
        home: const CharactersPage());
  }
}
