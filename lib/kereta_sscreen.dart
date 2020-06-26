import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:view_kereta/kereta_model2.dart';

class KeretaScreen extends StatefulWidget {
  @override
  _KeretaScreen createState() => _KeretaScreen();
}

class _KeretaScreen extends State<KeretaScreen> {
  Kereta kereta;

  Future getTrains() async {
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/train.json');
    var result = json.decode(data);
    kereta = Kereta.fromJson(result);
    //print(kereta.data.seat.departure.seatMap[0].avl[0].dataAvl);//untuk debug aja, jadi boleh dihapus
  }

  @override
  void initState() {
    super.initState();
    getTrains();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Kereta'),
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 4,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: ,
        ),
      ),
    );
  }
}
