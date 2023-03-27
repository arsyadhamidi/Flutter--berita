// import ini berfungsi untuk mendeklrasikan jsondecode atau jsonencode
import 'dart:convert';

// untuk pemanggilan class HomePade maka harus di import sesuai nama file
import 'package:berita/home_pages.dart';
// untuk pemanggilan atau pembuatan sebuah icon yang telah ditambahkan plugin pada file pubspec.yaml
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// untuk menambahkan atau import data alert yang telah ditambah plugin pada file pubspec.yaml
import 'package:awesome_dialog/awesome_dialog.dart';
// untuk memasukan atau import http pemasangan CRUD telah ditambah plugin pada file pubspec.yaml
import 'package:http/http.dart' as http;

class InsertBerita extends StatefulWidget {
  const InsertBerita({Key? key}) : super(key: key);

  @override
  State<InsertBerita> createState() => _InsertBeritaState();
}

class _InsertBeritaState extends State<InsertBerita> {

  // mendeklrasikan controller untuk melakukan penginputan data
  final TextEditingController _judul = TextEditingController();
  final TextEditingController _isiBerita = TextEditingController();

  // menghapus text yang ketika kita melakukan penginputan
  void clearText(){
    _judul.clear();
    _isiBerita.clear();
  }

  // membuat sebuah method dengan nama addDataBerita
  Future<void> addDataBerita() async {
    // membuat sebuah string url
    // 192.168.10.45 terdapat pada ipaddress yang terhubung baik wifi / hostpot
    // buka cmd ketik ipaddres dan pastikan wifi dan hostpot terhubung
    String url = 'http://192.168.10.45/berita/insertberita.php';

    // membuat sebuah try
    try {
      // membuat sebuah final bernama respon, jika insert kita menggunakan http.post
      final response = await http.post(Uri.parse(url), body: {
        // mendeklrasikan nama field sesuai dengan database  =  nama texteditingcontroller
        "judul": _judul.text.toString(),
        "isiberita": _isiBerita.text.toString(),
      });

      // membuat sebuah variable dengan nama addBerita dengan jsonEncode
      var addBerita = jsonEncode(response.body);
      // membuat sebuah kondisi
      // jika salah
      if (addBerita == "false") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.rightSlide,
          title: 'Informasi Berita',
          desc: 'Data Berita Gagal Ditambahkan',
          btnCancelOnPress: () {},
        )..show();
      } else { // jika benar
        AwesomeDialog(
          context: context,
          btnOkColor: Colors.green,
          dialogType: DialogType.SUCCES,
          animType: AnimType.rightSlide,
          title: 'Informasi Berita',
          desc: 'Data Berita Berhasil Ditambahkan!',
          btnOkOnPress: () {
            // jika berhasil maka kita akan menampilkan halaman selanjutnya yaitu ke halaman utama HomePage
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        )..show();
      }
    } catch (exp) {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "CNN Indonesia",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "CNN Indonesia",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Berita Terbaru",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    // membuat sebuah textformfield tempat penginputannya
                    child: TextFormField(
                      // membuat sebuah controller berdasarkan textediting controller
                      controller: _judul,
                      decoration: InputDecoration(
                          // letak icon nya disebalah kiri, untuk sebelah kanan kita menggunakan suffixicon
                          prefixIcon: Icon(CupertinoIcons.news),
                          // dengan tulisan dalam text hintext dan bisa kita menggunakan label
                          hintText: "Judul Berita...",
                          border: OutlineInputBorder(borderSide: BorderSide())),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    // membuat sebuah textformfield tempat penginputannya
                    child: TextFormField(
                      // membuat sebuah controller berdasarkan textediting controller
                      controller: _isiBerita,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.news),
                          hintText: "Isi Berita...",
                          border: OutlineInputBorder(borderSide: BorderSide())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      width: 300,
                      height: 50,
                      // membuat button proses untuk insert data ke database
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          // dengan method insert kita bikin addDataBerita
                          addDataBerita();
                          // melakukan penghapusan data inputkan
                          clearText();
                        },
                        child: Text(
                          "Simpan Berita",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
