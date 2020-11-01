import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroServiceApp/models/NewsDetailModel.dart';
import 'package:heroServiceApp/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({Key key}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  // สร้างตัวแปรไว้เก็บเลข id
  String newsId;
  // โหลด Model NewsDetailModel
  NewsDetailModel _dataNews;

  // สร้างฟังก์ชันอ่านรายละเอียดข่าว
  readNewsDetail() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      // ถ้า offline อยู่
      Fluttertoast.showToast(
        msg: "คุณไม่ได้เชื่อมต่ออินเตอร์เน็ต",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    } else {
      try{
        var response = await CallAPI().getNewsDetail(newsId);
        setState(() {
          _dataNews = response;
        });
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readNewsDetail();
  }

  @override
  Widget build(BuildContext context) {

    // รับค่า id จาก arguments
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    print(arguments['id'].toString());
    newsId = arguments['id'].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('${_dataNews?.data?.topic ?? "..."}'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_dataNews?.data?.imageurl ?? "..."),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('${_dataNews?.data?.detail}'),
          ),
          Padding(
            padding: EdgeInsets.only(left:16.0),
            child: Text('Created: ${_dataNews?.data?.createdAt}'),
          ),
          Padding(
            padding: EdgeInsets.only(left:16.0, bottom: 20.0),
            child: Text('Status: ${_dataNews?.data?.status}'),
          ),
        ],
      ),
    );
  }
}