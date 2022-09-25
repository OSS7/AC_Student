import 'package:ac_students/providers/marks.dart';
import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';
import 'package:provider/provider.dart';

class MarksItem extends StatelessWidget {
  final String? title;
  final String? link;
  const MarksItem({Key? key, this.title, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final marks = Provider.of<Marks>(context);
    return Container(
      padding: edge20,
      margin: edge20,
      width: size.width * 0.9,
      height: size.height * 0.10,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryClr, secondaryClr.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: radius25All,
      ),
      child: Center(
        child: ListTile(
          title: Text(
            title.toString(),
            style: TextStyle(color: primaryClr,fontSize: 20),
          ),
          trailing: Icon(
            Icons.download,
            color: primaryClr,
          ),
          onTap: (){
          marks.downloadMarks(context, title.toString(),link);
            },
        ),
      ),
    );
  }
}
