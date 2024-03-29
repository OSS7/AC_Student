import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/student/news/providers/news_provider.dart';
import 'package:ac_students/features/student/news/widgets/news_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.decelerate));
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final newses = Provider.of<NewsesProvider>(context, listen: false);
    final lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('NewsLabel'),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: SlideTransition(
          position: offset!,
          child: ListView.builder(
            itemCount: newses.news.length,
            itemBuilder: (context, index) {
              final varNews = newses.news[index];
              final varTitle = varNews.title.toString();
              DateTime? varDate = varNews.createdAt;
              // DateTime? varDate = varNews.createdAt;
              return NewsItem(
                txt: varTitle,
                createdAt: varDate,
              );
            },
          ),
        ),
      ),
    );
  }
}
