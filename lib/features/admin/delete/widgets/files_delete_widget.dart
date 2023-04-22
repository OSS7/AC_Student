import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/student/file/providers/files_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesDeleteWidget extends StatelessWidget {
  const FilesDeleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filesProvider = Provider.of<FilesProvider>(context );
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Files',
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
                  itemCount: filesProvider.files.length,
                  itemBuilder: (context, index) {
                    final varFile = filesProvider.files[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            varFile.name.toString(),
                            style: TextStyle(color: secondaryClr),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: errorClr,
                            ),
                            onPressed: () {
                              filesProvider.deleteFile(
                                  context, varFile.id.toString());
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
