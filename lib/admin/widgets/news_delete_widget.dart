
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';

import 'package:ac_students/providers/news.dart';

class NewsDeleteWidget extends StatelessWidget {
  const NewsDeleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<Newses>(context, listen: true);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'News',
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
                  itemCount: newsProvider.news.length,
                  itemBuilder: (context, index) {
                    final varNews = newsProvider.news[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            varNews.title.toString(),
                            style: TextStyle(color: secondaryClr),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: errorClr,
                            ),
                            onPressed: () {
                              newsProvider.deleteNews(
                                  context, varNews.id.toString());
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
