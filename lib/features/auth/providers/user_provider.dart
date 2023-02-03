import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/auth/model/variabel.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserProvider extends ChangeNotifier {
  final box = GetStorage();
  int? selectedIndex;
  int? selectedYear = 1;
  int? selectedSeason;
  int? selectedDepartment = 1;
  int? selectedPicture = 1;

  bool? isDark;
  int? secColor;

  String? userId;
  String? userName;
  String? userEmail;
  int? userYear;
  int? userDep;
  int? userImage;
  bool verfied = false;
  bool? isAdmin = false;

  Variabel? variabel;
  bool? enableChat = false;

  Future getVariables() async {
    final QueryBuilder<ParseObject> varQuery =
        QueryBuilder<ParseObject>(ParseObject('Variables'))
          ..whereEqualTo('year', userYear)
          ..whereEqualTo('department', userDep);
    ParseResponse varApiResponse = await varQuery.query();
    variabel = Variabel.decode(varApiResponse.results.toString()).first;
    enableChat = variabel?.enable;
    notifyListeners();
    // box.write('subjects', subjectApiResponse.results.toString());
  }

  Future<void> updateChatEnable(String? id) async {
    var todo = ParseObject('Variables')
      ..objectId = id
      ..set('enable', enableChat ?? false ? false : true);
    await todo.save();
    enableChat = !enableChat!;

    notifyListeners();
  }

  changProfilePicture(int img) {
    selectedPicture = img;
    notifyListeners();
  }

  Future<ParseUser> getCurrentUser() async {
    return await ParseUser.currentUser();
  }

  Future<bool> hasUserLogged() async {
    isDark = box.read('mode');
    secColor = box.read('color');
    primaryClr = isDark == true ? Colors.black : Colors.white;
    secondaryClr = Color(secColor!.toInt());
    // selectedPicture = box.read('pic_num');

    String? sessionToken = box.read('session');
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(sessionToken ?? '');
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    await getCurrentUser().then((value) {
      box.write('session', value.sessionToken);
      userId = value.objectId;
      verfied = value.emailVerified!;
      userEmail = value.emailAddress;
      userName = value.username;
      userYear = value.get('year');
      userImage = value.get<int>('img_num');
      userDep = value.get<int>('department');
      isAdmin = value.get('isAdmin');
    });
    if (!parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      //valid session. Login
      return true;
    }
  }

  void doUserLogin(TextEditingController emailC,
      TextEditingController passwordC, int year, BuildContext context) async {
    final email = emailC.text.trim();
    final password = passwordC.text.trim();
    final user = ParseUser(email, password, null);

    var response = await user.login();
    if (response.success) {
      Navigator.pushNamed(context, '/HomeScreen');

      await getCurrentUser().then((value) {
        box.write('session', value.sessionToken);
        userId = value.objectId;
        verfied = value.emailVerified!;
        userEmail = value.emailAddress;
        userName = value.username;
        userYear = value.get('year');
        userImage = value.get<int>('img_num');
        userDep = value.get<int>('department');
        isAdmin = value.get('isAdmin');
        // box.write('userId', value.objectId.toString());
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error!"),
            content: Text(response.error!.message.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void doUserLogout(BuildContext context) async {
    isAdmin = false;
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();
    var session = box.read('session');
    box.remove('session');
    box.remove('subjects');
    final userSession = ParseObject('User')..set('sessionToken', session);
    await userSession.delete();
    if (response.success) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/LoginScreen', (Route<dynamic> route) => false);
    } else {}
  }

  void createUser(BuildContext context, String username, String password,
      String confirmPassword, String email) async {
    if (username.trim().isEmpty ||
        password.trim().isEmpty ||
        email.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Empty Data! \n please fill all the field"),
        duration: Duration(seconds: 2),
      ));
      return;
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Wrong Confirm! \n please check the password confirm"),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    final user = ParseUser.createUser(username, password, email)
      ..set('year', selectedYear)
      ..set('department', selectedDepartment)
      ..set('img_num', selectedPicture);

    var response = await user.signUp();
    if (response.success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success!"),
            content: const Text(
                'User was successfully created! Please verify your email before Login'),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/LoginScreen', (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("error!"),
            content: Text(response.error!.message.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
