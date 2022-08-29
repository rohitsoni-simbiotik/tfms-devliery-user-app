import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/utils/ViewUtils.dart';
import 'package:tfms_delivery_user_app/widgets/AppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _authController = Get.find<AuthController>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProgressContainerView(
        isProgressRunning: _authController.showProgress,
        child: Scaffold(
          appBar: const AppBarWidget(title: 'New Password'),
          body: _body(),
        ),
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
              Text("Enter New Password", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
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
              const SizedBox(height: 20),
              Text("Confirm Password", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter confirm password';
                  } else if (value.length < 8) {
                    return 'Password length must be min 8 characters';
                  }
                  return null;
                },
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(16)
                ],
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: "Submit",
                isExpanded: true,
                onPressed: () {
                  _submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text != _confirmPasswordController.text) {
        toast('Password and Confirm Password doesn\'t match!');
      } else {
        _formKey.currentState?.save();
        _authController.resetPassword(_passwordController.text);
      }
    }
  }
}
