import 'dart:core';
import "package:flutter/material.dart";
import 'package:phonepe_clone/pages/payment_confirmation.dart';

class Payment extends StatefulWidget {
  String? upi;

  Payment({Key? key, this.upi}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double? amount;

  @override
  Widget build(BuildContext context) {
    RegExp reg1 = RegExp(r'(\bpa\b=[0-9]+@[a-zA-Z]+)');
    RegExp reg2 = RegExp(r'(\bpn\b=[a-zA-Z*0-9]+)');
    final payeeName;
    final paymentAdd = reg1.firstMatch(widget.upi!)?[0]?.split('=')[1];
    if(reg2.firstMatch(widget.upi!) == null){
      payeeName = "Name";
    }else{
      payeeName = reg2.firstMatch(widget.upi!)?[0]?.split('=')[1];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Payment"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                ),
                title: Text(payeeName!),
                subtitle: Text(paymentAdd!),
                trailing:
                    TextButton(onPressed: () {}, child: Text("View history"))),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  amount = double.parse(val);
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter amount',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentConfirmation(amount: amount,payeeName: payeeName)));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
            padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            // minimumSize: MaterialStateProperty.all()
          ),
          child: Text(
            "Proceed to pay",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
