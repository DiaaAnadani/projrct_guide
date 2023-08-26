// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CardPlace extends StatelessWidget {
  const CardPlace({super.key, required this.onTap, required this.placeImage, required this.placeName});
  final void Function()? onTap;
  final String placeImage;
  final String placeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            Container(
              width: 400,
              height: 150,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  placeImage,
                  fit: BoxFit.cover,
                ),
              
              ),
            ),
            Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
              height: 250,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                   placeName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "nava",
                  //       style: TextStyle(
                  //         color: Colors.grey[400],
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       placeName,
                  //       style:
                  //           const TextStyle(color: Colors.amber, fontSize: 16),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
