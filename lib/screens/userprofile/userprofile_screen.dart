import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroServiceApp/models/LoginModel.dart';
import 'package:heroServiceApp/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  // เรียกใช้งานตัวแปร SharedPrefference
  SharedPreferences sharedPreferences;

  // เรียกใช้งาน LoginModel
  LoginModel _dataProfile;
  String birthDate;

  // การอ่าน API User Profile
  readUserProfile() async {
    // เช็คว่าเครื่องผู้ใช้ Online หรือ Offline
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){ // ถ้า offline อยู่
      Fluttertoast.showToast(
          msg: "คุณไม่ได้เชื่อมต่ออินเตอร์เน็ต",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      // อ่านข้อมูลจาก SharePreferrence
      sharedPreferences = await SharedPreferences.getInstance();

      var userData = {
        'email': sharedPreferences.getString('storeEmail').toString(),
        'password': sharedPreferences.getString('storePassword').toString(),
      };

      try {
        var response = await CallAPI().getProfile(userData);
        // print(response);
        // print(response.data.firstname);
        setState(() {
          _dataProfile = response;
          birthDate = DateFormat("dd-MM-yyyy").format(DateTime.parse(response.data.birthdate.toString()));
        });
        
      }catch(error){
        print(error);
      } 
    }
  }

  @override
  void initState() {
    super.initState();
    readUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ชื่อ-สกุล'),
            subtitle: Text('${_dataProfile?.data?.firstname ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('รหัสผู้ใช้'),
            subtitle: Text('${_dataProfile?.data?.empid ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('เพศ'),
            subtitle: Text('${_dataProfile?.data?.gender ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('ตำแหน่ง'),
            subtitle: Text('${_dataProfile?.data?.position ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('สังกัด'),
            subtitle: Text('${_dataProfile?.data?.department ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('เงินเดือน'),
            subtitle: Text('${_dataProfile?.data?.salary ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('วันเกิด'),
            subtitle: Text('${birthDate ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('อีเมล์'),
            subtitle: Text('${_dataProfile?.data?.email ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('โทรศัพท์'),
            subtitle: Text('${_dataProfile?.data?.tel ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ที่อยู่'),
            subtitle: Text('${_dataProfile?.data?.address ?? "..."}'),
          )
        ],
      ),
    );
  }
}