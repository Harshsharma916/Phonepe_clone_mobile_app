import 'package:flutter/material.dart';
import 'package:phonepe_clone/pages/contacts.dart';

class TextButtons extends StatelessWidget {
  final dynamic icon;
  final dynamic text;
  final dynamic onPressed;

  const TextButtons({Key? key, this.icon, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onPressed(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(18.0)),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.0,
              )),
          SizedBox(height: 5.0),
          SizedBox(
            width: 65.0,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ]));
  }
}

class TextButtons2 extends StatelessWidget {
  final dynamic icon;
  final dynamic text;
  final dynamic onPressed;

  const TextButtons2({Key? key, this.icon, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(120.0, 10.0)),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0)),
            // background: rgba(78, 132, 218, 1);
            backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(78, 132, 218, 1.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: Colors.white,
            size: 35.0,
          ),
          SizedBox(height: 5.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ]));
  }
}

class PhonePayActions extends StatefulWidget {
  const PhonePayActions({Key? key}) : super(key: key);

  @override
  State<PhonePayActions> createState() => _PhonePayActionsState();
}

class _PhonePayActionsState extends State<PhonePayActions> {
  void onPressed(Widget route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transfer Money",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButtons(
                      icon: Icons.people,
                      text: "To Mobile Number",
                      onPressed: () => onPressed(Contacts()),
                    ),
                    TextButtons(
                      icon: Icons.send,
                      text: "To Bank/UPI",
                      onPressed: () => onPressed(Contacts()),
                    ),
                    TextButtons(
                      icon: Icons.arrow_circle_down,
                      text: "To self account",
                      onPressed: () => onPressed(Contacts()),
                    ),
                    TextButtons(
                      icon: Icons.home,
                      text: "Check account balance",
                      onPressed: () => onPressed(Contacts()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButtons2(
              icon: Icons.wallet,
              text: "PhonePe Wallet",
              onPressed: () {},
            ),
            TextButtons2(
              icon: Icons.card_giftcard,
              text: "Rewards",
              onPressed: () {},
            ),
            TextButtons2(
              icon: Icons.monetization_on_outlined,
              text: "Refer & earn",
              onPressed: () {},
            )
          ],
        ),
      )
    ]);
  }
}
