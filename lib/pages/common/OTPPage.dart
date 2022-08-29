import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/widgets/AppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _authController = Get.find<AuthController>();
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProgressContainerView(
        isProgressRunning: _authController.showProgress,
        child: Scaffold(
            appBar: const AppBarWidget(title: 'Verification'), body: _body()),
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
              Text("Enter Verification Code", style: Get.textTheme.subtitle1),
              const SizedBox(height: 10),
              TextFormField(
                controller: _codeController,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Please enter verification code';
                    } else if (value.length < 6) {
                      return 'Please enter 6 digit verification code';
                    }
                  }
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: "Verification Code",
                ),
              ),
              // const SizedBox(height: 10),
              Visibility(
                visible: !_authController.showProgress,
                maintainAnimation: true,
                maintainState: true,
                maintainSize: true,
                child: Align(
                    alignment: Alignment.center,
                    child: ResendOTP(60, _codeController)),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: "Verify",
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
      _formKey.currentState?.save();
      _authController.verifyOTP(_codeController.text);
    }
  }
}

class ResendOTP extends StatefulWidget {
  final int remainingTime;
  final TextEditingController txtController;

  const ResendOTP(
    this.remainingTime,
    this.txtController, {
    Key? key,
  }) : super(key: key);

  @override
  State<ResendOTP> createState() => _ResendOTPState();
}

class _ResendOTPState extends State<ResendOTP> {
  final controller = Get.find<AuthController>();

  var countDownTimerController = CustomTimerController();
  bool showResendBtn = false;
  bool showLoading = false;
  int timeInSecond = 120;

  @override
  void initState() {
    timeInSecond = widget.remainingTime;
    countDownTimerController.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: showResendBtn
          ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: showLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: PlatformCircularProgressIndicator(
                        key: const Key('ResendProgress'),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'If you didn\'t receive a code  ',
                          style: Get.textTheme.subtitle2!.copyWith(
                            color: ColorConstants.TEXT_GREY,
                            fontWeight: FontWeight.normal,
                            // fontSize: 18,
                          ),
                        ),
                        InkWell(
                          key: const Key('Resend'),
                          onTap: () async {
                            widget.txtController.clear();
                            setState(() {
                              showLoading = true;
                            });
                            controller.reSendOTP(onResend: (remainingTime) {
                              setState(() {
                                timeInSecond = remainingTime;
                                countDownTimerController =
                                    CustomTimerController();
                                countDownTimerController.start();
                                showResendBtn = false;
                              });
                            }, onFinally: () {
                              setState(() {
                                showLoading = false;
                              });
                            });
                          },
                          child: Text(
                            'Resend',
                            style: Get.textTheme.subtitle1!.copyWith(
                              color: ColorConstants.PRIMARY,
                              fontWeight: FontWeight.w500,
                              // fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          : CustomTimer(
              controller: countDownTimerController,
              onChangeState: (state) {
                if (state == CustomTimerState.finished) {
                  setState(() {
                    showResendBtn = true;
                  });
                }
              },
              begin: Duration(seconds: timeInSecond),
              end: const Duration(),
              builder: (remaining) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "${remaining.minutes}:${remaining.seconds}",
                    style: Get.textTheme.button!.copyWith(
                      color: ColorConstants.PRIMARY,
                      // fontSize: 18,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
