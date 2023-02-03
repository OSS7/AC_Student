import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/auth_button.dart';
import 'package:ac_students/core/widgets/custom_text_fields.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/auth/sign_up/widgets/choose_picture.dart';
import 'package:ac_students/features/auth/sign_up/widgets/dep_row.dart';
import 'package:ac_students/features/auth/sign_up/widgets/year_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Directionality(
        textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: secondaryClr,
          body: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: primaryClr,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/LoginScreen', (route) => false);
                        },
                      ),
                    ),
                    // const CustomLogo(),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: primaryClr.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 25,
                            offset: const Offset(
                                0, -5), // changes position of shadow
                          ),
                        ],
                        color: primaryClr,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    width: size.width * 1,
                    // height: size.height * 0.750,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            height: size.height * 0.2,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: SizedBox(
                                      width: size.width * 0.4,
                                      height: size.height * 0.2,
                                      child: CircleAvatar(
                                        backgroundColor: primaryClr,
                                        child: Image.asset(
                                            'images/avatars/${userProvider.selectedPicture ?? 1}.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ChoosePicture();
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: secondaryClr,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomTextField(
                                control: firstNameController,
                                hntText: lan.get('FirstName'),
                                size: inputSize.small,
                              ),
                              CustomTextField(
                                control: lastNameController,
                                hntText: lan.get('LastName'),
                                size: inputSize.small,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomTextField(
                            control: emailController,
                            hntText: lan.get('Email'),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          DepartmentWidget(
                            selectedDepartment: selectedIndex,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          YearWidget(
                            selectedIndex: selectedIndex,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomTextField(
                            control: passwordController,
                            hntText: lan.get('Password'),
                            type: inputType.password,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomTextField(
                              control: confirmPasswordController,
                              hntText: lan.get('ConfirmPassword'),
                              type: inputType.password),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          AuthButton(
                              onPress: () {
                                if (firstNameController.text.isEmpty ||
                                    lastNameController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Empty Data! \n please fill all the field"),
                                    duration: Duration(seconds: 2),
                                  ));
                                } else {
                                  userProvider.createUser(
                                    context,
                                    '${firstNameController.text.toString()} ${lastNameController.text.toString()}',
                                    passwordController.text.toString(),
                                    confirmPasswordController.text.toString(),
                                    emailController.text.toString(),
                                    // (sel)??1
                                  );
                                  // print(data.selectedYear);
                                }
                              },
                              label: lan.get('SignUp').toString()),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
