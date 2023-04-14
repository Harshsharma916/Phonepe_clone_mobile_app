import 'package:flutter/material.dart';
import 'package:phonepe_clone/components/PhonePeActions.dart';
import 'package:phonepe_clone/components/adverts.dart';
import 'package:phonepe_clone/components/header.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(child: Header()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.paypal), Text("Pay through UPI")],
                ),
              ),
            ),
            Adverts(),
            PhonePayActions(),
            SizedBox(height: 14),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Image(
                    image: AssetImage('assets/images/recharge_bill.png'))),
            SizedBox(height: 14),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Image(image: AssetImage('assets/images/insurance.png'))),
          ],
        ),
      ),
    );
  }
}
