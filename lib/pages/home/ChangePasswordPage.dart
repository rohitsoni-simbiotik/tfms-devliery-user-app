import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/controller/HomeController.dart';
import 'package:tfms_delivery_user_app/pages/home/DrawerPage.dart';
import 'package:tfms_delivery_user_app/utils/ViewUtils.dart';
import 'package:tfms_delivery_user_app/widgets/DrawerAppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _authController = Get.find<AuthController>();
  final _homeController = Get.find<HomeController>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProgressContainerView(
        isProgressRunning:
            _authController.showProgress || _homeController.showProgress,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: DrawerAppBarWidget(
              title: 'Change Password',
              leadingCallback: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              toggleSwitchCallback: (value) {
                _homeController.setIsSwitchOn = value;
              },
              switchValue: _homeController.isSwitchOn),
          drawer: const Drawer(child: DrawerPage(drawerIndex: 1)),
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
              Text("Old Password", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter old password';
                  } else if (value.length < 8) {
                    return 'Password length must be min 8 characters';
                  }
                  return null;
                },
                controller: _oldPasswordController,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(16)
                ],
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 20),
              Text("Enter New Password", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  } else if (value.length < 8) {
                    return 'Password length must be min 8 characters';
                  }
                  return null;
                },
                controller: _newPasswordController,
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
      if (_newPasswordController.text != _confirmPasswordController.text) {
        toast('New Password and Confirm Password doesn\'t match!');
      } else {
        _formKey.currentState?.save();
        _authController.changePassword(_newPasswordController.text);
      }
    }
  }
}
