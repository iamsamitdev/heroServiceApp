import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScanCheckInScreen extends StatefulWidget {
  QRScanCheckInScreen({Key key}) : super(key: key);

  @override
  _QRScanCheckInScreenState createState() => _QRScanCheckInScreenState();
}

class _QRScanCheckInScreenState extends State<QRScanCheckInScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _flashOn = false;
  bool _frontCam = false;
  GlobalKey _qrKey = GlobalKey();
  QRViewController _controller;

  File _image;
  String _data = '';
  String _qrcodeFile = '';

  Future getImage() async {
    var image = await ImagePickerSaver.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      _displaySnackBar(context, _image.toString());
      _launchInBrowser(_image.toString());
    });
  }

  @override
  void initState() {
    super.initState();

    String filename = '1559788943.png';
    Observable.fromFuture(getTemporaryDirectory())
        .flatMap((tempDir) {
          File qrCodeFile = File('${tempDir.path}/$filename');
          bool exists = qrCodeFile.existsSync();
          if (exists) {
            return Observable.just(qrCodeFile);
          } else {
            return Observable.fromFuture(
                    rootBundle.load("assets/images/$filename"))
                .flatMap((bytes) => Observable.fromFuture(
                    qrCodeFile.writeAsBytes(bytes.buffer.asUint8List(
                        bytes.offsetInBytes, bytes.lengthInBytes))));
          }
        })
        .flatMap((file) =>
            Observable.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path)))
        .listen((data) {
          setState(() {
            _data = data;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Check In'),
      ),
      body: Stack(
        children: [
          QRView(
              key: _qrKey,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderLength: 15.0,
                  borderWidth: 5.0,
                  borderRadius: 2.0),
              onQRViewCreated: (QRViewController controller) {
                this._controller = controller;
                controller.scannedDataStream.listen((val) {
                  // print(val);
                  if (mounted) {
                    _controller.dispose();
                    _displaySnackBar(context, _image.toString());
                    _launchInBrowser(val);
                  }
                });
              }),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60),
              child: Text(
                'วางคิวอาร์โค้ดให้อยู่ในกรอบเพื่อสแกน',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: OutlineButton(
                onPressed: _getPhotoByGallery,
                child: Text(
                  "นำเข้าจากแกลเลอรี่",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                borderSide: BorderSide(color: Colors.white),
                shape: StadiumBorder(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      color: Colors.white,
                      icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                      onPressed: () {
                        setState(() {
                          _flashOn = !_flashOn;
                          _controller.toggleFlash();
                        });
                      }),
                  IconButton(
                      color: Colors.white,
                      icon: Icon(
                          _frontCam ? Icons.camera_front : Icons.camera_rear),
                      onPressed: () {
                        setState(() {
                          _frontCam = !_frontCam;
                          _controller.flipCamera();
                        });
                      }),
                  IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String msg) {
    final scaff = Scaffold.of(context);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 8),
      action: SnackBarAction(
        label: 'ปิด',
        onPressed: scaff.hideCurrentSnackBar,
      ),
    ));
  }

  void _displaySnackBar(BuildContext context, String msg) {
    final scaff = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 8),
      action: SnackBarAction(
        label: 'ปิด',
        onPressed: _scaffoldKey.currentState.hideCurrentSnackBar,
      ),
    );
    _scaffoldKey.currentState.showSnackBar(scaff);
  }

  void _getPhotoByGallery() {
    Observable.fromFuture(
            ImagePickerSaver.pickImage(source: ImageSource.gallery))
        .flatMap((file) {
      setState(() {
        _qrcodeFile = file.path;
      });
      return Observable.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path));
    }).listen((data) {
      setState(() {
        _data = data;
        // _showSnackbar(context, _data.toString());
        _displaySnackBar(context, _data.toString());
        _launchInBrowser(_data.toString());
      });
    }).onError((error, stackTrace) {
      setState(() {
        _data = '';
      });
      print('${error.toString()}');
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
