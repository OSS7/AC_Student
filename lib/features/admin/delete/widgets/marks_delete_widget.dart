import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/student/mark/providers/marks_provider.dart';
import 'package:ac_students/features/student/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarksDeleteWidget extends StatelessWidget {
  const MarksDeleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marksProvider = Provider.of<MarksProvider>(context );
    final size = MediaQuery.of(context).size;
    final subjectProvider =
        Provider.of<SubjectsProvider>(context );

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
