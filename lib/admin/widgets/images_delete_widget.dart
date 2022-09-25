import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';

import 'package:ac_students/providers/images.dart';

class PhotoDeleteWidget extends StatelessWidget {
  const PhotoDeleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<Images>(context, listen: true);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Images',
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
            height: size.height * 0.4,
            child: Center(
              child: ListView.builder(
                  itemCount: photoProvider.images.length,
                  itemBuilder: (context, index) {
                    final varPhoto = photoProvider.images[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            varPhoto.title.toString(),
                            style: TextStyle(color: secondaryClr),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: errorClr,
                            ),
                            onPressed: () {
                              photoProvider.deletePhoto(
                                context,
                                varPhoto.id.toString(),
                              );
                              // subjectProvider.subjects
                              //     .firstWhere(
                              //         (element) => element.id == varMarks.id)
                              //     .name;
                            },
                          ),
                        ),
                        Divider(
                          color: secondaryClr,
                        ),
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
