{{> licence.dart }}

import 'package:flutter/material.dart';

import '../../app_extensions.dart';
import '../../base/common_ui_components/custom_app_bar.dart';
import '../../lib_social_logins/ui_components/apple_login_widget.dart';
import '../../lib_social_logins/ui_components/facebook_login_widget.dart';
import '../../lib_social_logins/ui_components/google_login_widget.dart';
import '../ui_components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: customAppBar(
          context,
          title: context.l10n.featureLogin.loginPageTitle,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.designSystem.spacing.xxl2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginForm(
                  title: context.l10n.featureLogin.loginCredentialsHint,
                ),
                SizedBox(height: context.designSystem.spacing.xs),
                const FacebookLoginWidget(),
                SizedBox(height: context.designSystem.spacing.xs),
                const AppleLoginWidget(),
                SizedBox(height: context.designSystem.spacing.xs),
                const GoogleLoginWidget(),
              ],
            ),
          ),
        ),
      );
}
