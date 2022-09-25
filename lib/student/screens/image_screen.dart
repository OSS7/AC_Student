import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/models/photo.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/providers/language_provider.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)?.settings.arguments as Photo;
    final lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
            txt: lan.get('PhotoLabel').toString(),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/GalleryScreen');
              },
              icon: const Icon(Icons.arrow_back_outlined),
            )),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: Container(
          padding: edge20,
          child: InteractiveViewer(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: image.url.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
