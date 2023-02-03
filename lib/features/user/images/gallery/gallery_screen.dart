import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/user/images/image/providers/images_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imagesProvider = Provider.of<ImagesProvider>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryClr,
        appBar: AppBarWidget(
          txt: lan.get('GalleryLabel'),
        ),
        drawer: const DrawerWidget(),
        body: GridView.builder(
          itemCount: imagesProvider.images.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1.8 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            final varPhoto = imagesProvider.images[index];
            String? varFileUrl = varPhoto.url;
            String? varTitle = varPhoto.title ?? 'no title';
            String? varId = varPhoto.id ?? '0';
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/ImageScreen',
                    arguments: varPhoto);
              },
              child: Container(
                margin: edge10,
                decoration: BoxDecoration(
                  borderRadius: radius25All,
                  border: Border.all(
                    width: 2,
                    color: secondaryClr,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CachedNetworkImage(
                          imageUrl: varFileUrl.toString(),
                        ),
                      ),
                    ),
                    Container(
                      padding: edge5,
                      height: size.height * 0.035,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: secondaryClr,
                          borderRadius: radius25BottomRightLeft),
                      child: FittedBox(
                        child: Text(
                          varTitle.toString(),
                          style: TextStyle(color: primaryClr),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
