import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:view_kereta/kereta_model2.dart';
import 'kereta_model2.dart';

class KeretaScreen extends StatefulWidget {
  @override
  _KeretaScreen createState() => _KeretaScreen();
}

class _KeretaScreen extends State<KeretaScreen> {
  Kereta kereta;
  List<ListAvl> avl;
  int lengthRowGrid;
  Color warnaTidakAda = Colors.transparent;
  Color warnaKosong = Colors.grey;
  Color warnaIsi = Colors.red;
  Color warnaTerpilih = Colors.green;

  //bisa diganti dengan map, dimapkan dengan penumpang
  List<String> listKursiTerpilih = List<String>();

  //Asumsi sudah tau bentuk JSOnnya jadi untuk kolom diHardcode
  List<String> columnKursi = ['A', 'B', 'C', 'D'];
  Map<String, List<Widget>> mappingKursi; //untuk membentuk Grid View Kursi

  Future getTrains() async {
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/train.json');
    var result = json.decode(data);
    kereta = Kereta.fromJson(result);

    setState(() {
      //ambil contoh untuk satu gerbong, untuk setiap gerbong tinggal diloop sebanyak gerbong
      //memang datanya cukup kompleks jadi yaa memang agak ruwet jadinya nanti, hehe
      avl = kereta.data.seat.departure.seatMap[0].avl;
      lengthRowGrid = kereta.data.seat.departure.seatMap[0].jmlRow;

      int penunjukKursi = 0; //untuk sebagai tanda sampai mana data Avl dicek
      for (int i = 0; i < lengthRowGrid; i++) {
        for (int j = 0; j < columnKursi.length; j++) {
          String padaLokal = '${columnKursi[j]}${i + 1}';
          String padaApi =
              '${avl[penunjukKursi].dataAvl[1]}${avl[penunjukKursi].dataAvl[0]}';
          if (padaLokal == padaApi) {
            //karena penunjukKursi ditambah terus jadi perlu dicopy
            int current = penunjukKursi;
            Color colorCurrent = avl[current].dataAvl[3] == 0
                ? listKursiTerpilih.contains(padaApi)
                    ? warnaTerpilih
                    : warnaKosong
                : warnaIsi;
            mappingKursi[columnKursi[j]].add(flatButtonKursi(
              posisiKursi: padaApi,
              colorCurrent: colorCurrent,
              kolom: columnKursi[j],
              baris: i,
            ));
            penunjukKursi++;
          } else {
            mappingKursi[columnKursi[j]].add(Container());
          }
        }
      }
    });
  }

  FlatButton flatButtonKursi(
      {String posisiKursi, Color colorCurrent, String kolom, int baris}) {
    return FlatButton(
      child: Text(posisiKursi),
      color: colorCurrent,
      onPressed: () {
        if (colorCurrent != warnaIsi) {
          kursiTerpilih(
            posisiKursi: posisiKursi,
            kolom: kolom,
            baris: baris,
          );
        }
      },
    );
  }

  kursiTerpilih({String posisiKursi, String kolom, int baris}) {
    //dibuat seperti toogle
    setState(() {
      if (listKursiTerpilih.contains(posisiKursi)) {
        listKursiTerpilih.remove(posisiKursi);
        mappingKursi[kolom][baris] = flatButtonKursi(
          posisiKursi: posisiKursi,
          baris: baris,
          colorCurrent: warnaKosong,
          kolom: kolom,
        );
      } else {
        listKursiTerpilih.add(posisiKursi);
        mappingKursi[kolom][baris] = flatButtonKursi(
          posisiKursi: posisiKursi,
          baris: baris,
          colorCurrent: warnaTerpilih,
          kolom: kolom,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listKursiTerpilih.add('B6');
    mappingKursi = {
      columnKursi[0]: List<Widget>(),
      columnKursi[1]: List<Widget>(),
      columnKursi[2]: List<Widget>(),
      columnKursi[3]: List<Widget>(),
    };
    getTrains();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Kereta'),
      ),
      body: lengthRowGrid == null
          ? Center(
              child: Text('Sedang memuat'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: lengthRowGrid,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mappingKursi[columnKursi[0]][index],
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mappingKursi[columnKursi[1]][index],
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mappingKursi[columnKursi[2]][index],
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mappingKursi[columnKursi[3]][index],
                    )),
                  ],
                );
              },
            ),
    );
  }
}
