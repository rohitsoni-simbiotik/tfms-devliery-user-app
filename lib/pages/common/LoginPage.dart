import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/constants/AssetConstants.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/pages/common/ForgorPasswordPage.dart';
import 'package:tfms_delivery_user_app/utils/InputUtils.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authController = Get.find<AuthController>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ProgressContainerView(
          isProgressRunning: _authController.showProgress,
          child: Stack(
            children: [
              Image.asset(AssetConstants.LOGIN_BG,
                  width: Get.width, height: Get.height, fit: BoxFit.cover),
              _titleWidget(),
            ],
          ),
        ),
      ),
    );
  }

  _titleWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Image.asset(
            AssetConstants.LOGO_TEXT,
            height: 180,
            width: 180,
          ),
          // const SizedBox(height: 20),
          Text(
            'Login to Account',
            style:
                Get.textTheme.headline6?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              'Please enter your email and password to continue',
              style: Get.textTheme.subtitle1
                  ?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          _inputWidget()
        ],
      ),
    );
  }

  _inputWidget() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email Address", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: (value) => InputUtils.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "Email ID"),
              ),
              const SizedBox(height: 18),
              Text("Password", style: Get.textTheme.subtitle1),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 8) {
                    return 'Password length must be min 8 characters';
                  }
                  return null;
                },
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(16)
                ],
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 40),
              RoundedButton(
                text: "Log In",
                isExpanded: true,
                onPressed: () {
                  _submit();
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.to(() => const ForgotPasswordPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("Forgot Password?",
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: ColorConstants.PRIMARY,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _authController.login(_emailController.text, _passwordController.text);
    }
  }
}
