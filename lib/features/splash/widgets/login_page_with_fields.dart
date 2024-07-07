import 'dart:developer';

import 'package:car_pool/features/home/screen/home.dart';
import 'package:car_pool/features/splash/widgets/formatted_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TextFormField(
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
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
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
                hintStyle: const TextStyle(
                    color: activeGray,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: activeGray))),
            onChanged: (value) {
              var str = value.replaceAll(' ', '');
              if (str == '9895000111') {
                log("Match--------");
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
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: const TextStyle(
                        color: activeGray,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: activeGray))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: const TextStyle(
                        color: activeGray,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: activeGray))),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ).animate().fade(begin: 1, end: authorized ? 0 : 1),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'By clicking continue, you agree to our\n',
                  ),
                  TextSpan(
                    text: 'Terms of Service & Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (authorized) {
                  Get.to(Home());
                } else {}
              },
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  fixedSize:
                      WidgetStatePropertyAll(Size(widget.screenWidth, 55)),
                  backgroundColor:
                      const WidgetStatePropertyAll(loginButtonGreen)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      authorized ? "Continue" : "Login",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Icon(
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
