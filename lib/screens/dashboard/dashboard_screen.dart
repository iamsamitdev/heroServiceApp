import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroServiceApp/screens/bottomnav/booking_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/home_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/market_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/notification_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้างตัวแปรแบบ List ไว้เก็บรายการของ tab bottom
  int _currentIndex = 2;
  String _title='Hero Service';

  final List<Widget> _children = [
    MarketScreen(),
    BookingScreen(),
    HomeScreen(),
    NotificationScreen(),    
    SettingScreen()
  ];

  // สร้างฟังก์ชันเพื่อใช้ในการเปลี่ยนหน้า
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      // เปลี่ยน title ไปตาม tab ที่เลือก
      switch (index) {
        case 0: _title = 'ตลาด';          
          break;
        case 1: _title = 'รายการจอง';          
          break;
        case 2: _title = 'บริการ';          
          break;
        case 3: _title = 'แจ้งเตือน';          
          break;
        case 4: _title = 'อื่นๆ';          
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('$_title'),
      //   actions: [
      //     FlatButton.icon(
      //       onPressed: () => _openScanner(context), 
      //       icon: Icon(Icons.center_focus_strong, color: Colors.white,), 
      //       label: Text('Scan', style: TextStyle(color: Colors.white),)
      //     )
      //   ],
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white, /* สีพื้นหลัง */
        color: Colors.teal, /* สีพื้นเมนู */
        buttonBackgroundColor: Colors.teal,
        height: 60,
        animationDuration: Duration(
          milliseconds: 200
        ),
        index: 2,
        animationCurve: Curves.bounceInOut,
        items: [
          Icon(Icons.shopping_basket, size: 30, color: Colors.white,), // ตลาด
          Icon(Icons.library_books, size: 30, color: Colors.white,), // รายการจอง
          Icon(Icons.business_center, size: 30, color: Colors.white,), // บริการ
          Icon(Icons.notifications, size: 30, color: Colors.white,), // แจ้งเตือน
          Icon(Icons.menu, size: 30, color: Colors.white,), // อื่นๆ
        ],
        onTap: onTabTapped,
      ),
      body: _children[_currentIndex],
    );
  }

}