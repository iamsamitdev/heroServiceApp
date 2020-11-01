import 'package:flutter/material.dart';
import 'package:heroServiceApp/screens/qrcode/mycode_screen.dart';
import 'package:heroServiceApp/screens/qrcode/scanner_screen.dart';

class QRCodeScreen extends StatefulWidget {
  QRCodeScreen({Key key}) : super(key: key);

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> with SingleTickerProviderStateMixin {
  
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คิวอาร์โค้ด'),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: 'ตัวสแกน',),
            Tab(text: 'โค้ดของฉัน',)
          ]
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          ScannerScreen(),
          MyCodeScreen(),
        ]
      ),
    );
  }
}