
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';

import 'package:ac_students/providers/marks.dart';
import 'package:ac_students/providers/subjects.dart';

class MarksDeleteWidget extends StatelessWidget {
  const MarksDeleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marksProvider = Provider.of<Marks>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final subjectProvider = Provider.of<Subjects>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Marks',
                style: TextStyle(color: secondaryClr, fontSize: 20),
              ),
              Expanded(
                  child: Divider(
                    color: secondaryClr,
                  ))
            ],
          ),
          SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.3,
            child: Center(
              child: ListView.builder(
                  itemCount: marksProvider.marks.length,
                  itemBuilder: (context, index) {
                    final varMarks = marksProvider.marks[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            subjectProvider.subjects
                                .firstWhere((element) =>
                            element.id == varMarks.subjectId)
                                .name
                                .toString(),
                            style: TextStyle(color: secondaryClr),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: errorClr,
                            ),
                            onPressed: () {
                              marksProvider.deleteMarks(
                                  context, varMarks.id.toString());
                              // subjectProvider.subjects
                              //     .firstWhere(
                              //         (element) => element.id == varMarks.id)
                              //     .name;
                            },
                          ),
                        ),
                        Divider(
                          color: secondaryClr,
                        )
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
