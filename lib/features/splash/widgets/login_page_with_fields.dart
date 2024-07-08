//This file/class has least refactorability as reference to an enclosing class method cannot be extracted.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../../common/custom_snackbar.dart';
import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../../../core/twilio_file_not_to_be_tracked.dart';
import '../../home/screen/home.dart';

class LoginPageWithFields extends StatefulWidget {
  const LoginPageWithFields({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<LoginPageWithFields> createState() => _LoginPageWithFieldsState();
}

class _LoginPageWithFieldsState extends State<LoginPageWithFields> {
  bool authorized = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  var twilioFlutter = TwilioFlutter(
      accountSid: accountSID, authToken: authToken, twilioNumber: twilioNumber);
  String _formatNumber(String number) {
    String digitsOnly = number.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 4 || i == 7) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    return formatted;
  }

  Future<void> _sendOtp() async {
    try {
      await twilioFlutter.sendVerificationCode(
          verificationServiceId: serviceSID,
          recipient: '+91${_phoneNumberController.text.replaceAll(' ', '')}',
          verificationChannel: VerificationChannel.SMS);
    } catch (error) {
      showCustomSnackBar(message: error.toString());
    }
  }

  Future<void> _verifyOtp() async {
    TwilioResponse response = await twilioFlutter.verifyCode(
        verificationServiceId: 'sid',
        recipient: '+91${_phoneNumberController.text.replaceAll(' ', '')}',
        code: _otpController.text.trim());
    if (response.metadata!['status'] == 'approved') {
      Get.to(const Home());
    } else {
      showCustomSnackBar(message: 'Invalid OTP');
    }
  }

  void _showOtpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    iconSize: 20,
                    color: Colors.black,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const Text(
                  'Verify your Mobile',
                  style: loginPageOtpVerifyPopUpHeadingTS,
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: loginPageOtpVerifyPopUpTextSpanTS,
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              'Verification code has been sent to your registered mobile '),
                      TextSpan(
                        text:
                            'XXXX XXX ${_phoneNumberController.text.substring(8)}',
                        style: otpVerifyPopUpNumberTS,
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                onChanged: (value) async {
                  if (value.length == 6) {
                    await _verifyOtp();
                    _otpController.clear();
                    Get.back();
                  }
                },
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                controller: _otpController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: activeGray)),
                    hintText: 'Enter OTP *',
                    hintStyle: loginPageOtpVerifyPopUpEnterOtpFieldTS),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _sendOtp();
              },
              child: const Text('Resend Code',
                  style: loginPageOtpVerifyPopUpResendCodeTS),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TextFormField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
              TextInputFormatter.withFunction((oldValue, newValue) {
                String newText = _formatNumber(newValue.text);
                return newValue.copyWith(
                  text: newText,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: newText.length),
                  ),
                );
              }),
            ],
            style: loginPageFieldsInputTS,
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: authorized
                      ? Container(
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 1, color: authorizedTickGreen))),
                          child: const Icon(
                            Icons.check_sharp,
                            color: authorizedTickGreen,
                            size: 20,
                          ),
                        )
                      : Container(
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(
                                  side: BorderSide(width: 1, color: retryRed))),
                          child: const Icon(
                            Icons.replay,
                            color: retryRed,
                            size: 20,
                          ),
                        ),
                ),
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: activeGray,
                ),
                hintText: "Mobile Number*",
                hintStyle: loginPageMobileNumberHintTS,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: activeGray))),
            onChanged: (value) {
              var str = value.replaceAll(' ', '');
              if (str == '9895000111') {
                //Checks for given number 9895000111
                setState(() {
                  authorized = true;
                });
              } else {
                setState(() {
                  authorized = false;
                });
              }
            },
          ),
          FadeableFieldsinLogin()
              .animate()
              .fade(begin: 1, end: authorized ? 0 : 1),
          TandC(),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (authorized) {
                  Get.to(const Home());
                } else {
                  _sendOtp();
                  _showOtpDialog();
                }
              },
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  fixedSize:
                      WidgetStateProperty.all(Size(widget.screenWidth, 55)),
                  backgroundColor:
                      const WidgetStatePropertyAll(loginButtonGreen)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      authorized ? "Login" : "Continue",
                      style: loginPageLoginButtonTS,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class TandC extends StatelessWidget {
  const TandC({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.left,
        text: const TextSpan(
          style: loginPageTandCTextSpanTS,
          children: <TextSpan>[
            TextSpan(
              text: 'By clicking continue, you agree to our\n',
            ),
            TextSpan(
              text: 'Terms of Service & Privacy Policy',
              style: loginPageTandCBoldLettersSecondLine,
            ),
          ],
        ),
      ),
    );
  }
}

class FadeableFieldsinLogin extends StatelessWidget {
  const FadeableFieldsinLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          style: loginPageFieldsInputTS,
          decoration: InputDecoration(
              hintText: "Full Name",
              hintStyle: loginPageMobileNumberHintTS,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: activeGray))),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          style: loginPageFieldsInputTS,
          decoration: InputDecoration(
              hintText: "Email",
              hintStyle: loginPageMobileNumberHintTS,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: activeGray))),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
