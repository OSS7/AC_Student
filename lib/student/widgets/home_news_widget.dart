import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/loading_circle.dart';
import 'package:ac_students/student/widgets/news_item.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNewsWidget extends StatelessWidget {
  const HomeNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final newsProvider = Provider.of<Newses>(context, listen: true);

    return newsProvider.news.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      lan.get('NewsLatest').toString(),
                      style: TextStyle(fontSize: 18, color: secondaryClr),
                    ),
                    Expanded(
                        child: Divider(
                      color: secondaryClr,
                    ))
                  ],
                ),
              ),
              newsProvider.news.isEmpty
                  ? const LoadingCircle()
                  : SizedBox(
                      width: size.width,
                      height: size.height * 0.25,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newsProvider.news.length,
                        itemBuilder: (context, index) {
                          return NewsItem(
                            txt: newsProvider.news[index].title,
                            createdAt: newsProvider.news[index].createdAt,
                          );
                        },
                      ),
                    ),
            ],
          );
  }
}
