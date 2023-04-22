import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/student/images/gallery/model/photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
