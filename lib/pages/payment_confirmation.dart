import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PaymentConfirmation extends StatefulWidget {
  final double? amount;
  final payeeName;

  const PaymentConfirmation({Key? key, this.amount, this.payeeName})
      : super(key: key);

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  Timer? timer2;
  bool phonePeLoading = true;
  double moveVal = 0;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    timer2 = Timer(Duration(seconds: 1), () {
      playLocal();
      setState(() {
        phonePeLoading = false;
      });
    });
  }

  Future playLocal() async {
    String assetUrl = 'phonePe_sound.mp3';
    Source source = AssetSource(assetUrl);
    await audioPlayer.play(source);
    // await audioPlayer.setSourceAsset(assetUrl);
    // final player = AudioCache(prefix: 'assets/');
    // final url = await player.load('phonePe_sound.mp3');
    // String assetUrl = url.path;
    // await audioPlayer.setSource(source);
    // await audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return phonePeLoading == true
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(32, 162, 92, 1.0),
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white, size: 40.0),
            ),
          )
        : Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.8,
                width: double.infinity,
                child: Container(
                  color: Color.fromRGBO(32, 162, 92, 1.0),
                  height: double.infinity,
                  child: Center(
                      child: SizedBox(
                    width: 300.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 60.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Payment of ₹${widget.amount} to ${widget.payeeName} Successful",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                print('object');
                              },
                              style: buttonStyle,
                              child: Text(
                                style: TextStyle(color: Colors.white),
                                "VIEW DETAILS",
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                                onPressed: () {},
                                style: buttonStyle,
                                child: Text("CHECK BALANCE",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        )
                      ],
                    ),
                  )),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 2.9,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height / 3.2,
                  left: MediaQuery.of(context).size.width / 2 - 30.0,
                  child: Stack(children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(32, 162, 92, 1.0),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    Positioned(
                      top: moveVal,
                      left: 8,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ])),
            ],
          );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }
}

ButtonStyle buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.white, width: 1.0))),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.0)),
    overlayColor: MaterialStateProperty.all(Color.fromRGBO(16, 80, 46, 1.0)));
