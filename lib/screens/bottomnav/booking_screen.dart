import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('หน้ารายการจอง'),
      ),
    );
  }
}