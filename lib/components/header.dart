import 'package:flutter/material.dart';
import 'package:phonepe_clone/pages/scanner.dart';
import 'package:phonepe_clone/pages/scanner_2.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      // background: rgba(95, 37, 158, 1);
      color: Color.fromRGBO(95, 37, 158, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Harsh",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  "Sector 30",
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ],
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QRViewExample()));
                    },
                    icon: Icon(
                      Icons.document_scanner_outlined,
                      color: Colors.white,
                    )),
                SizedBox(width: 20.0),
                Icon(
                  Icons.notification_important,
                  color: Colors.white,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
