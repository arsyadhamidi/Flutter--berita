// import ini berfungsi untuk mendeklrasikan jsondecode atau jsonencode
import 'dart:convert';

// untuk pemanggilan class InsertBerita maka harus di import sesuai nama file
import 'package:berita/insert_pages.dart';
// untuk pemanggilan class UpdateBerita maka harus di import sesuai nama file
import 'package:berita/update_pages.dart';
// untuk pemanggilan atau pembuatan sebuah icon yang telah ditambahkan plugin pada file pubspec.yaml
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// untuk memasukan atau import http pemasangan CRUD telah ditambah plugin pada file pubspec.yaml
import 'package:http/http.dart' as http;
// umtuk memasukan atau import data waktu yang telah ditambah plugin pada file pubspec.yaml
import 'package:intl/intl.dart';
// untuk menambahkan atau import data alert yang telah ditambah plugin pada file pubspec.yaml
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';

// class disini bernama HomePage dengan extends StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // membuat sebuah list dengan nama LisDataBerita
  List lisDataBerita = [];

  // membuat sebuah method untuk delete yang bernama deleteDataBerita
  // pada String id, data tersebut di hapus berdasarkan id
  Future<void> deleteDataBerita(String id) async {

    // menampung data berupa string
    // sesuaikan dengan ipaddress kita masing-masing
    // 192.168.10.45 di dapat dari ipaddress yang jaringan internet berupa wifi/hostpot hp
    // berita/deleteberita.php didapatkan pada folder berita yang terletak pada folder xampp/htdocs
    String url = 'http://192.168.10.45/berita/deleteberita.php';

    // membuat sebuah try
    try {
      // membuat sebuah variable response
      // untuk delete tersebut kita menggunakan http.post
      // pada bagian body, kita menghapus data berdasarkan id
      var response = await http.post(Uri.parse(url), body: {"id": id});

      // membuat sebuah variable delberita dengan melakukan pertukaran data jsonDecode pada body
      var delBerita = jsonDecode(response.body);

      // kita membuat sebuah kondisi jika data tersebut berhasil di hapus
      if (delBerita["success"] == "true") {
        // awesomedialog ini merupakan syntax secara default yang ada pada libray flutter pubdev
        AwesomeDialog(
          context: context,
          btnOkColor: Colors.green,
          dialogType: DialogType.SUCCES,
          animType: AnimType.rightSlide,
          title: 'Informasi Berita',
          desc: 'Data Berita Berhasil DiHapus!',
          btnOkOnPress: () {},
        )..show();
        // setelah di hapus getdataberita untuk menampilkan data list berita lagi yang terbaru
        getDataBerita();
      } else { // kondisi jika gagal di hapus
        // awesomedialog ini merupakan syntax secara default yang ada pada libray flutter pubdev
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.rightSlide,
          title: 'Informasi Berita',
          desc: 'Data Berita Gagal Dihapus',
          btnCancelOnPress: () {},
        )..show();
      }
    } catch (exc) {}
  }

  // sebuah method untuk menampilkan data berita dengan nama getDataBertia
  Future<void> getDataBerita() async {

    // menampung data berupa string
    // sesuaikan dengan ipaddress kita masing-masing
    // 192.168.10.45 di dapat dari ipaddress yang jaringan internet berupa wifi/hostpot hp
    // berita/selectberita.php didapatkan pada folder berita yang terletak pada folder xampp/htdocs
    String url = 'http://192.168.10.45/berita/selectberita.php';

    // membuat sebuah try
    try {
      // membuat sebuah final bernama response dengan menampilkan data yaitu http.get
      final response = await http.get(Uri.parse(url));

      // menampung list bernama lisDataBerita dengan pertukaran data jsonDecode
      lisDataBerita = jsonDecode(response.body);
      //merencanakan suatu pembaruan ke suatu state objek komponen
      setState(() {
        // dengan list bernama lisDataBerita
        lisDataBerita = jsonDecode(response.body);
      });
    } catch (exp) {}
  }

  // Untuk menginisialisasi data yang bergantung pada BuildContext tertentu seperti getDataBerita
  @override
  void initState() {
    // method menampilkan get GetDataBerita
    getDataBerita();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // memberikan sebuah warna putih untuk background aplikasi
      backgroundColor: Colors.white,
      // membuat sebuah tombol bulat tambah floating yang terletak pada bagian suduk kiri bawah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // berfungsi untuk pindah halaman ke halaman berikutnya
          Navigator.push(
              // InsertBerita terdapat pada nama Class pada file insert_berita
              context, MaterialPageRoute(builder: (context) => InsertBerita()));
        },
        // dengan warna tombolnya red
        backgroundColor: Colors.red,
        // dengan menampilkan icon tambah bisa menggunakan Icons/CupertinoIcons
        child: Icon(CupertinoIcons.add),
        hoverColor: Colors.red[700],
      ),

      // membuat sebuah appbar bagian atas
      appBar: AppBar(
        // menghilangkan tombol leading atau bagian kiri appbar
        automaticallyImplyLeading: false,
        // dengan warna appbarnya merah
        backgroundColor: Colors.red,
        // disini dengan memberikan sebuah judul bernama CNN Indonesia
        title: Text(
          "CNN Indonesia",
          // membuat sebuah style dengan ketebalannya bold
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // ini merupakan bagian body dengan ListView.Builder
      body: ListView.builder(
        // menampilkan data sebanyak data yang ada di dalam database
        // sesuai dengan keinginan untuk menampilkan data
        itemCount: lisDataBerita.length,
        // membuat itembuilder untuk menampilkan sebuah data disini dibikin index
        itemBuilder: (context, index) {
          // membuat tampilan berupa berbentuk card
          return Card(
            // memberikan jarak margin
            margin: EdgeInsets.all(20),
            // lebih lanjut disini menggunakan button untuk menampilkan data berita
            // tergantung kebutuhan
            child: RaisedButton(
              // buttonnya berwarna putih
              color: Colors.white,
              onPressed: () {},
              // membuat sebuah column
              child: Column(
                // dengan berada diposisi sebalah kiri
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // membuat sebuah listile tampilan
                  ListTile(
                    title: Text(
                      // menampikan field database judul dengan mendaklarasikan lisDataBerita
                      lisDataBerita[index]["judul"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    // membuat sebuah subtitle
                    subtitle: Column(
                      // membuat tampilan semua disebelah kiri
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // memberikan jarak dengan menggunakan padding
                        Padding(
                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                          // membuat sebuah text
                          child: Text(
                              // membuat sebuah format tanggal,bulan, tahun
                              DateFormat('yyyy-mm-dd').format(DateTime.now()),
                              // memberika style dengan ketebalan bold dan warna merah
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ),
                        // menampilkan isi berita
                        Text(lisDataBerita[index]["isiberita"]),
                      ],
                    ),
                  ),
                  // menampilkan tombol button ke samping menggunakan row
                  Row(
                    children: [
                      // membuat padding ukuran
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        // membuat tombol button update
                        child: RaisedButton(
                          // dengan warna merah
                          color: Colors.red,
                          // dengan onpressed
                          onPressed: () {
                            // menanmpilkan ke halaman selanjutnya
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // dengan mengambil nilai berdasarkan id dan menampilkannya ke updateberita
                                    builder: (context) => UpdateBerita(
                                      ListData: {
                                        "id" : lisDataBerita[index]["id"],
                                        "judul" : lisDataBerita[index]["judul"],
                                        "isiberita" : lisDataBerita[index]["isiberita"],
                                      },
                                    )
                                ));
                          },
                          // dengan nama tombol update
                          child: Text("Update",
                              // memberi style tulisan button dengan warna putih dengan ketebalan bold
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      // membuat sebuah ukuran jarak padding
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        // membuat button untuk delete
                        child: RaisedButton(
                          // dengan warna kuning
                          color: Colors.yellow[700],
                          // dengan onpressed
                          onPressed: () {
                            // berdasarkan method delete berdasarkan indexnya id
                            deleteDataBerita(lisDataBerita[index]["id"]);
                          },
                          // membuat nama button delete
                          child: Text("Delete",
                              // membuat style dengan tulisan warna putih, dengan ketebalan bold
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
