import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/auth/screens/login.dart';
import 'package:app_tentify_frfr/onboarding/widgets/welcome_page.dart';
import 'package:app_tentify_frfr/onboarding/widgets/findcars_card.dart';
import 'package:app_tentify_frfr/onboarding/widgets/starRent_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}): super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  
  final List<Widget> subScreens = [
    const WelcomePage(), 
    const FindBikes(),
    const StartAdventure(),
  ];

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: subScreens,
            onPageChanged: (index) {
              setState(() => onLastPage = (index + 1 == subScreens.length));
            },
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(subScreens.length - 1);
                  },
                  child: const Text("Skip")
                ),
                
                SmoothPageIndicator(controller: _controller, count: subScreens.length),
                
                onLastPage ?
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const Login())
                      );
                    },
                    child: const Text("Done")
                  )
                  :
                  GestureDetector(
                    onTap: () {
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child: const Text("Next")
                  )
              ]
            )
          )
        ],
      )
    );
  }
}