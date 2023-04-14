import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:phonepe_clone/pages/payment.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QRViewExample extends StatefulWidget {
  Barcode? result;

  QRViewExample({Key? key, this.result}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return widget.result == null
        ? Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(flex: 4, child: _buildQrView(context)),
                // Expanded(
                //   flex: 1,
                //   child: FittedBox(
                //     fit: BoxFit.contain,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: <Widget>[
                //         if (result != null)
                //           Text(
                //               'Barcode Type: ${result!.format}   Data: ${result!.code}')
                //         else
                //           const Text('Scan a code'),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: <Widget>[
                //             Container(
                //               margin: const EdgeInsets.all(8),
                //               child: ElevatedButton(
                //                   onPressed: () async {
                //                     await controller?.toggleFlash();
                //                     setState(() {});
                //                   },
                //                   child: FutureBuilder(
                //                     future: controller?.getFlashStatus(),
                //                     builder: (context, snapshot) {
                //                       return Text('Flash: ${snapshot.data}');
                //                     },
                //                   )),
                //             ),
                //             Container(
                //               margin: const EdgeInsets.all(8),
                //               child: ElevatedButton(
                //                   onPressed: () async {
                //                     await controller?.flipCamera();
                //                     setState(() {});
                //                   },
                //                   child: FutureBuilder(
                //                     future: controller?.getCameraInfo(),
                //                     builder: (context, snapshot) {
                //                       if (snapshot.data != null) {
                //                         return Text('Camera facing');
                //                       } else {
                //                         return const Text('loading');
                //                       }
                //                     },
                //                   )),
                //             )
                //           ],
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: <Widget>[
                //             Container(
                //               margin: const EdgeInsets.all(8),
                //               child: ElevatedButton(
                //                 onPressed: () async {
                //                   await controller?.pauseCamera();
                //                 },
                //                 child: const Text('pause',
                //                     style: TextStyle(fontSize: 20)),
                //               ),
                //             ),
                //             Container(
                //               margin: const EdgeInsets.all(8),
                //               child: ElevatedButton(
                //                 onPressed: () async {
                //                   await controller?.resumeCamera();
                //                 },
                //                 child: const Text('resume',
                //                     style: TextStyle(fontSize: 20)),
                //               ),
                //             )
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          )
        : Center(
            child: LoadingAnimationWidget.inkDrop(
                color: Colors.blueAccent, size: 40.0),
          );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 5,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        print(scanData.code);
        setState(() {
          widget.result = scanData;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Payment(upi: scanData.code)));
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
