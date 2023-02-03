import 'package:ac_students/core/constant/constant.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final String? txt;
  final DateTime? createdAt;

  const NewsItem({
    Key? key,
    this.txt,
    this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: secondaryClr,
        boxShadow: [
          BoxShadow(
            color: secondaryClr.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
          colors: [
            secondaryClr.withOpacity(0.4),
            secondaryClr,
          ],
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      width: size.width * 0.8,
      height: size.height * 0.15,
      padding: edge20,
      margin: edge20,
      child: Center(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${txt ?? 'nothing new'} \n',
                style: TextStyle(fontSize: 20, color: primaryClr),
                // textAlign: TextAlign.center,
              ),
              Text(
                "${createdAt?.year} / ${createdAt?.month} / ${createdAt?.day}",
                style: TextStyle(color: primaryClr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
