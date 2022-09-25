import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';

class SubjectItem extends StatefulWidget {
  String title;
  String route;
  int subjectId;
  bool isFromHome = false;

  SubjectItem(this.title, this.route, this.subjectId, this.isFromHome,
      {Key? key})
      : super(key: key);

  @override
  State<SubjectItem> createState() => _SubjectItemState();
}

class _SubjectItemState extends State<SubjectItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, widget.route, arguments: {
          'id': widget.subjectId,
          'isFromHome': widget.isFromHome
        });
      },
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.4,
        padding: edge5,
        margin: edge10,
        child: Center(
          child: FittedBox(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  backgroundColor: secondaryClr,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryClr),
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage(
              'images/subject.png',
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryClr.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            colors: [secondaryClr.withOpacity(0.5), primaryClr],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
