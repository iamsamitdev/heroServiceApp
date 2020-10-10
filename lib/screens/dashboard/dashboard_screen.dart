import 'package:flutter/material.dart';
import 'package:heroServiceApp/screens/bottomnav/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Service'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center, color: Colors.white,), 
            title: Text('บริการ', style: TextStyle(color: Colors.white ),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white,), 
            title: Text('ตลาด', style: TextStyle(color: Colors.white ),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books, color: Colors.white,), 
            title: Text('รายการจอง', style: TextStyle(color: Colors.white ),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.white,), 
            title: Text('อื่นๆ', style: TextStyle(color: Colors.white ),)
          ),
        ]
      ),
      body: HomeScreen(),
    );
  }
}