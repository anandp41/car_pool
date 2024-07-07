import 'package:car_pool/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'widgets/login_page_with_fields.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: const Text(
                      'Get a new experience',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                        .animate(delay: 1000.ms)
                        .fade(begin: 1, end: 0, delay: 600.ms),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 100,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 44,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Car',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Pool',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .animate(delay: 1000.ms)
                .slideY(duration: 200.ms, end: 0.8)
                .then()
                .slideY(duration: 800.ms, end: -5.7)
                .then()
                .slideY(duration: 300.ms, end: 0.5),
            Positioned(
              bottom: -500,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.25,
                child: SizedBox(
                  width: 200,
                  height: 450,
                  child: Image.asset(
                    'assets/images/car.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
                .animate(delay: 1000.ms)
                .slideY(end: 0.5)
                .then()
                .slideY(duration: 800.ms, end: -1.55)
                .then()
                .slideY(duration: 300.ms, end: 0.1),
            Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: LoginPageWithFields(screenWidth: screenWidth))
                .animate()
                .fadeIn(delay: 3000.ms),
          ],
        ));
  }
}
