import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

String assetAddress = 'assets/images';

class Adverts extends StatelessWidget {
  final List carouselImages = [
    {
      "img": '$assetAddress/advert_1.png',
    },
    {
      "img": '$assetAddress/advert_2.png',
    },
    {
      "img": '$assetAddress/advert_3.png',
    },
    // {
    //   "img": '$assetAddress/transfer_money.jpg',
    //   "text": "EASY",
    //   "color": Color.fromRGBO(60, 82, 161, 1.0)
    // },
    // {
    //   "img": '$assetAddress/money_notes.jpg',
    //   "text": "CASHIN"
    //       "",
    //   "color": Color.fromRGBO(38, 98, 39, 1.0)
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 2.0),
      child: CarouselSlider(
        options: CarouselOptions(height: 150.0, enableInfiniteScroll: true,autoPlay: true,autoPlayInterval: Duration(seconds: 2)),
        items: carouselImages.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Image(image: AssetImage(i["img"])));
              // Stack(
              //   alignment: AlignmentDirectional.center,
              //   children: [
              //     Flexible(
              //       child: Image(
              //           image: AssetImage(i["img"]),
              //           color: Color.fromRGBO(255, 255, 255, 0.5),
              //           colorBlendMode: BlendMode.modulate),
              //     ),
              //     Text(
              //       i["text"],
              //       textAlign: TextAlign.left,
              //       style: TextStyle(
              //           color: i["color"],
              //           letterSpacing: 8.0,
              //           fontFamily: 'Rowdies',
              //           fontSize: 50.0,
              //           fontWeight: FontWeight.w700),
              //     ),
              //   ],
              // ));
            },
          );
        }).toList(),
      ),
    );
  }
}
