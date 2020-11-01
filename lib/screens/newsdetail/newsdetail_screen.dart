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
  // เรียกใช้งาน NewsModel
  NewsDetailModel _dataNews;
  String newsID;

  readNewsDetail() async {
    // เช็คว่าเครื่องผู้ใช้ Online หรือ Offline
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
      try {
        var response = await CallAPI().getNewsByID(newsID);
        // print(response);
        // print(response.data.firstname);
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
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    newsID = arguments['id'].toString();
    // print(arguments['id'].toString());
    print(newsID);

    return Scaffold(
        appBar: AppBar(
          title: Text('${_dataNews?.data?.detail ?? "..."}'),
        ),
        body: ListView(
          children: [
            Container(
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_dataNews?.data?.imageurl ?? "..."),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('${_dataNews?.data?.detail ?? "..."}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Text('Created: ${_dataNews?.data?.createdAt ?? "..."}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, bottom: 24.0),
              child: Text('Status: ${_dataNews?.data?.status ?? "..."}'),
            )
          ],
        ));
  }
}
