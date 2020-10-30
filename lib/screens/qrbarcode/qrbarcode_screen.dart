import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroServiceApp/screens/components/borderpaint.dart';

class QRBarcodeScreen extends StatefulWidget {
  QRBarcodeScreen({Key key}) : super(key: key);

  @override
  _QRBarcodeScreenState createState() => _QRBarcodeScreenState();
}

class _QRBarcodeScreenState extends State<QRBarcodeScreen> {
  String _qrInfo = 'แสกน qrcode หรือบาร์โค้ด';
  bool _camState = false;
  bool _isOn = true;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แสกน'),
      ),
      body: _camState
          ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black87,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: QRBarScannerCamera(
                      fit: BoxFit.cover,
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      qrCodeCallback: (code) {
                        _qrCallback(code);
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 160.0),
                    child: CustomPaint(
                      painter: BorderPainter(),
                      child: Container(
                        width: 250.0,
                        height: 250.0,
                        child: Center(
                          child: Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 170.0,
                  left: 10.0,
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        _isOn = false;
                      });
                      Fluttertoast.showToast(
                          msg: "เปิด flash แล้ว",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }, 
                    child: Icon(
                      _isOn ? Icons.flash_off : Icons.flash_on,
                      size: 30.0,
                      color: Colors.white,
                    )
                  )
                ),
                Positioned(
                  bottom: 170.0,
                  right: 10.0,
                  child: FlatButton(
                    onPressed: (){
                      Fluttertoast.showToast(
                          msg: "สลับไปใช้กล้องหน้าแล้ว",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }, 
                    child: Icon(
                      Icons.camera_front,
                      size: 30.0,
                      color: Colors.white,
                    )
                  )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    color: Colors.teal,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: (){}, 
                                child: Text(
                                  'แสกน QR Code', 
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 20.0
                                  ),
                                )
                              ),
                              FlatButton(
                                onPressed: (){}, 
                                child: Text(
                                  'แสกนบาร์โค้ด', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        RaisedButton(
                          onPressed: (){},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          color: Colors.purple,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'เลือกรูปภาพ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          )
          : Center(
              child: Text(_qrInfo),
            ),
    );
  }

}
