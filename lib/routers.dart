import 'package:flutter/material.dart';
import 'package:heroServiceApp/screens/dashboard/dashboard_screen.dart';
import 'package:heroServiceApp/screens/lockscreen/lock_screen.dart';
import 'package:heroServiceApp/screens/login/login_screen.dart';
import 'package:heroServiceApp/screens/profile_detail/profile_detail_screen.dart';
import 'package:heroServiceApp/screens/qrbarcode/qrbarcode_screen.dart';
import 'package:heroServiceApp/screens/qrcode/qrcode_screen.dart';
import 'package:heroServiceApp/screens/qrscancheckin/qrscancheckin_screen.dart';
import 'package:heroServiceApp/screens/welcome/welcome_screen.dart';

// สร้างตัวแปร Map ไว้เก็บ URL และ Screen
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/qrbarcode": (BuildContext context) => QRBarcodeScreen(),
  "/qrcode": (BuildContext context) => QRCodeScreen(),
  "/qrscancheckin": (BuildContext context) => QRScanCheckInScreen(),
  "/profiledetail": (BuildContext context) => ProfileDetailScreen(),
};