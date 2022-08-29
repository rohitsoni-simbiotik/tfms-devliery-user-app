import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/utils/InputUtils.dart';
import 'package:tfms_delivery_user_app/widgets/AppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _authController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProgressContainerView(
        isProgressRunning: _authController.showProgress,
        child: Scaffold(
            appBar: const AppBarWidget(title: 'Forgot Password'),
            body: _body()),
      ),
    );
  }

  _body() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter Email Address", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: (value) => InputUtils.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: "Email ID",
                ),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: "Send",
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
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("Back to Log in",
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: ColorConstants.PRIMARY,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _authController.forgotPassword(_emailController.text);
    }
  }
}
