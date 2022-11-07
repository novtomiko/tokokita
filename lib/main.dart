import 'package:flutter/material.dart';
import 'package:tokokita/ui/produk_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState(); 
}
 
class _MyAppState extends State<MyApp> {

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      home: ProdukPage(),
    );
  }
 }