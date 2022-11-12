import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toggle)
      : SignupPage(
          onClickedSignIn: toggle,
        );

  void toggle() => setState(() => isLogin = !isLogin);
}
