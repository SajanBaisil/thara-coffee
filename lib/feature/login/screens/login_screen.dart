import 'package:flutter/material.dart';
import 'package:thara_coffee/feature/login/widgets/common_auth_screen.dart';
import 'package:thara_coffee/feature/login/widgets/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      child: LoginWidget(),
    );
  }
}
