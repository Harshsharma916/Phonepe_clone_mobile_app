import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool cameraPermission = false;
  String barCodeValue = "";

  void getStatus() async {
    PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        cameraPermission = true;
      });
    } else if (status == PermissionStatus.denied) {
      ScaffoldMessenger(child: Text("Please give access to contacts"));
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Mobile Scanner')),
        body: cameraPermission == true && barCodeValue.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                child: MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;
                        debugPrint('Barcode found! $code');
                        setState(() {
                          barCodeValue = code;
                        });
                      }
                    }),
              )
            : barCodeValue.isNotEmpty
                ? Text(barCodeValue)
                : Text("data"));
  }
}
