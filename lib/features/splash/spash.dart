import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/textstyles.dart';
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
                      style: splashPageSubTitleTS,
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
                    style: splashPageAppTitleTextSpanTS,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Car',
                        style: splashPageAppTitleCarTS,
                      ),
                      TextSpan(
                        text: 'Pool',
                        style: splashPageAppTitlePoolTS,
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
