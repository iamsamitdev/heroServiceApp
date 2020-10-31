import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroServiceApp/screens/components/passwordwidget.dart';
import 'package:heroServiceApp/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // กำหนดตัวแปรสำหรับเก็บอีเมล์และรหัสผ่าน
  String _email, _password;

  // สร้างคีย์สำหรับเก็บสถานะของฟอร์ม
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: (){
          // ยกเลิกการ focus ช่อง input
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20, color: Colors.teal),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'กรอกอีเมล์'
                  ),
                  // maxLength: 5,
                  // initialValue: 'samit@gmail.com',
                  validator: (value){
                    if(value.isEmpty){
                      return 'กรุณากรอกอีเมล์ก่อน';
                    }else{
                      return null;
                    }
                  },
                  onFieldSubmitted: (String value){
                    setState(() {
                      this._email = value;
                    });
                  },
                  onSaved: (value){
                    this._email = value.trim();
                  },
                ),
                PasswordField(
                  helperText: 'ไม่เกิน 6 หลัก',
                  labelText: 'กรอกรหัสผ่าน',
                  validator: (value){
                    if(value.isEmpty){
                      return 'กรุณากรอกรหัสผ่านก่อน';
                    }else if(value.length != 6){
                      return 'กรุณาป้อนรหัสผ่านด้วยเลข 6 หลัก';
                    }else{
                      return null;
                    }
                  },
                  onFieldSubmitted: (String value){
                    setState(() {
                      this._password = value;
                    });
                  },
                  onSaved: (value){
                    this._password = value.trim();
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  onPressed: (){
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      // print(_email + _password);
                      var userData = {
                        'email': _email,
                        'password': _password
                      };
                      _loginProcess(userData);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 20.0, color: Colors.white),),
                  ),
                  color: Colors.green,
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันเช็คการล็อกอิน
  void _loginProcess(userData) async {

    try{

      var response = await CallAPI().loginAPI(userData);
      var body = json.decode(response.body);

      print(body['message']);
      
      // เช็คว่าถ้าลงทะเบียนสำเร็จ
      if(body['status']=='success' && body['data']['status']=='1'){
        
        // สร้าง Object แบบ Sharedprefference
        SharedPreferences sharedPreferences = 
        await SharedPreferences.getInstance();

        // เก็บค่าลงตัวแปรแบบ SharedPrefference
        sharedPreferences.setInt('appStep', 2);
        sharedPreferences.setString('storeFullname', body['data']['prename'] + body['data']['firstname'] +' '+ body['data']['lastname']);
        sharedPreferences.setString('storeAvatar', body['data']['avatar']);
        sharedPreferences.setString('storeEmail', body['data']['email']);
        sharedPreferences.setString('storePassword', _password);

        // ส่งไปหน้า dashboard
        Navigator.pushReplacementNamed(context, '/dashboard');
      }else{
        _showDialog('มีข้อผิดพลาด', 'ข้อมูลไม่ถูกต้อง ลองใหม่');
      }

    }catch(e){
      Fluttertoast.showToast(
          msg: "มีข้อผิดพลาดการโหลดข้อมูล",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


  }

  void _showDialog(title,msg){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            FlatButton(
              onPressed: (){Navigator.of(context).pop();}, 
              child: Text('Close'))
          ],
        );
      }
    );
  }



}