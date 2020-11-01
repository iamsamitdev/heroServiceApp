import 'package:flutter/material.dart';

class MyCodeScreen extends StatefulWidget {
  MyCodeScreen({Key key}) : super(key: key);

  @override
  _MyCodeScreenState createState() => _MyCodeScreenState();
}

class _MyCodeScreenState extends State<MyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('my code'),
    );
  }
}