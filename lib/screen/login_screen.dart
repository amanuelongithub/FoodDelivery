import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/utils/dimenstions.dart';
import 'package:fooddelivery/utils/fade_animation.dart';
import 'package:fooddelivery/utils/fade_animation_auth.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../components/changethemebutton.dart';
import '../components/default_button.dart';
import '../main.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPressed = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  ChangeThemeButton(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35),
                          ),
                          Text(
                            "Login to continue...",
                            style: TextStyle(
                                color: AppColors.maincolor,
                                fontSize: Dimensions.font18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: emailController,
                      showCursor: true,
                      cursorColor: Color.fromARGB(255, 126, 126, 126),
                      enableInteractiveSelection: true,
                      autofillHints: [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 126, 126, 126),
                            fontWeight: FontWeight.bold),
                        border: inputBorder,
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              Icons.mail_outlined,
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      showCursor: true,
                      cursorColor: Color.fromARGB(255, 126, 126, 126),
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 126, 126, 126),
                            fontWeight: FontWeight.bold),
                        border: inputBorder,
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              color: Color.fromARGB(255, 126, 126, 126),
                              icon: FaIcon(
                                isPressed
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                              },
                            ),
                          ],
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: isPressed,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Color.fromARGB(221, 130, 130, 130),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width30),
                        child: DefaultButton(text: "Login", press: signIn)),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 30),
              child: RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Create new account?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.maincolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: AppColors.maincolor),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((rout) => rout.isFirst);
  }
}
