import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ac_students/data/constant.dart';

class SeasonItem extends StatelessWidget {
  String id;
  String title;
  Color color;
  SeasonItem(this.id, this.title, this.color, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.4,
      margin: edge20,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: secondaryClr.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(140)),
        gradient: LinearGradient(
          colors: [secondaryClr.withOpacity(0.6), secondaryClr],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.2,
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: primaryClr),
            ),
          ),
          Positioned(
              bottom: size.height * 0.04,
              right: size.width * 0.1,
              child: SizedBox(
                  width: 350,
                  height: size.height * 0.3,
                  child: Image.asset(
                    'images/subject.png',
                    fit: BoxFit.fill,
                  )))
        ],
      ),
    );
  }
}
