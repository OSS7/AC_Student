import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/providers/user.dart';
import 'package:ac_students/home/widgets/year_txt.dart';
import 'package:provider/provider.dart';

class SeasonWidget extends StatefulWidget {
  int? selectedIndex;

  SeasonWidget({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<SeasonWidget> createState() => _SeasonWidgetState();
}

class _SeasonWidgetState extends State<SeasonWidget> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: size.width * 0.9,
              // height: size.height * 0.70,
              child: Text(
                'Which season',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: secondaryClr),
              )),
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.05,
            child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        userProvider.selectedSeason = index + 1;
                        widget.selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          color: widget.selectedIndex == index
                              ? secondaryClr
                              : secondaryClr.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child: index == 0
                            ? const Txt('1st year')
                            : index == 1
                                ? const Txt('2nd year')
                                : index == 2
                                    ? const Txt('3rd year')
                                    : index == 3
                                        ? const Txt('4th year')
                                        : index == 4
                                            ? const Txt('5th year')
                                            : const Text('null'),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}