import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/service/authe_methode.dart';
import 'package:fooddelivery/utils/dimenstions.dart';
import '../../utils/colors.dart';
import '../utils/utils.dart';
import '../components/bottomnav.dart';
import '../components/changethemebutton.dart';
import '../components/default_button.dart';
import '../main.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignupPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phonenumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    phonenumController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  const ChangeThemeButton(),
                ],
              ),
            ),
            Form(
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView(
                    children: [
                      SizedBox(height: Dimensions.height45 + 15),

                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Create new",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                            Text(
                              "Account",
                              style: TextStyle(
                                  color: AppColors.maincolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60),
                      TextFormField(
                        controller: usernameController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "User name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.user,
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phonenumController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Mobile number",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.phone_outlined,
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              FaIcon(
                                Icons.mail_outline,
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        // maxLength: 9,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.lock_outline,
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      // Flexible(
                      //   child: Container(),
                      //   flex: 1,
                      // ),
                      SizedBox(
                        height: Dimensions.height60,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width30),
                          child:
                              DefaultButton(text: "Create", press: signUpUser)),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: Dimensions.height30),
              child: RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Have account?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.maincolor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font16))),
            )
          ],
        ),
      ),
    );
  }

  void signUpUser() async {
    // bool iscorrect = confirumPass();

    // if (iscorrect) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: AppColors.maincolor),
            ));

    String res = await AuthMethods().signUpUser(
        email: emailController.text,
        phoneNum: phonenumController.text,
        username: usernameController.text,
        password: passwordController.text);
    if (res != "success") {
      Utils.showSnackBar(res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    }
    navigatorKey.currentState!.popUntil((rout) => rout.isFirst);

    // } else {
    //   Utils.showSnackBar("Password not match");
    // }
  }

  // bool confirumPass() {
  //   if (passwordController.text == confirumController.text) {
  //     return true;
  //   } else
  //     return false;
  // }
}
