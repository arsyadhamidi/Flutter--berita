import 'dart:convert';

import 'package:berita/home_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

class UpdateBerita extends StatefulWidget {
  // membuat sebuah final map untuk penampungan data yang mau di edit
  final Map ListData;
  // membaca data berdasarkan listData
  const UpdateBerita({Key? key, required this.ListData}) : super(key: key);

  @override
  State<UpdateBerita> createState() => _UpdateBeritaState();
}

class _UpdateBeritaState extends State<UpdateBerita> {

  // mendeklrasikan controller untuk melakukan udpate data
  final TextEditingController _id = TextEditingController();
  final TextEditingController _judul = TextEditingController();
  final TextEditingController _isiBerita = TextEditingController();

  // membuat sebuah method update bernama updateDataBerita
  Future<void> updateDataBerita() async {
    // membuat sebuah string url
    // 192.168.10.45 terdapat pada ipaddress yang terhubung baik wifi / hostpot
    // buka cmd ketik ipaddres dan pastikan wifi dan hostpot terhubung
    String url = 'http://192.168.10.45/berita/updateberita.php';

    // membuat sebuah try
    try {
      // membuat sebuah final bernama respon, jika insert kita menggunakan http.post
      final response = await http.post(Uri.parse(url), body: {
        // mendeklrasikan nama field sesuai dengan database  =  nama texteditingcontroller
        "id": _id.text.toString(),
        "judul": _judul.text.toString(),
        "isiberita": _isiBerita.text.toString(),
      });

      // membuat sebuah variable disingkat var updateBerita dengan petukaran data jsonEncode
      var updateBerita = jsonEncode(response.body);
      // membuat sebuah kondisi
      // kondisi jika gagal
      if (updateBerita == "false") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.rightSlide,
          title: 'Informasi Berita',
          desc: 'Data Berita Gagal Diperbaharui',
          btnCancelOnPress: () {},
        )..show();
      //  jika berhasil update
      } else {
        AwesomeDialog(
          context: context,
          btnOkColor: Colors.green,
          dialogType: DialogType.SUCCES,
          animType: AnimType.rightSlide,
          title: 'Informasi Berita',
          desc: 'Data Berita Berhasil Diperbaharui!',
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
    // mendeklrasikan tampung data berdasarkan halaman sebelumnya dan ListData diatas
    _id.text=widget.ListData['id'];
    _judul.text=widget.ListData['judul'];
    _isiBerita.text=widget.ListData['isiberita'];
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
                          prefixIcon: Icon(CupertinoIcons.news),
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
                      // membuat button proses untuk update data ke database
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          // dengan method insert kita bikin updateDataBerita
                          updateDataBerita();
                        },
                        child: Text(
                          "Update Berita",
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
