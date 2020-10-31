import 'dart:async';

import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatefulWidget {
  ProfileDetailScreen({Key key}) : super(key: key);

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {

  StreamSubscription _scanSubscription;
  Map<String, MiScaleDevice> devices = {}; // <Id, MiScaleDevice>
  final _scale = MiScale.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('น้ำหนัก'),
                    Text('65', style: TextStyle(fontSize: 60.0),)
                  ],
                ),
                Column(
                  children: [
                    Text('ส่วนสูง'),
                    Text('165', style: TextStyle(fontSize: 60.0),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}