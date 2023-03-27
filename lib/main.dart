import 'package:flutter/material.dart';
// untuk pemanggilan class HomePage maka harus di import sesuai nama file
import './home_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home ini di deklarasikan oleh file home_pages pada classnya
      home: HomePage(),

      // pada bagian ini berfungsi untuk menghilangkan banner pada appbar
      debugShowCheckedModeBanner: false,

      // memberikan judul yaitu berita
      title: "Berita",
    );
  }
}

