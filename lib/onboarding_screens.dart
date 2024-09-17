import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  final List<Widget> pages = [
    buildPage(
        title: "Track Spending",
        text:
            "Easily keep track of your daily expenses to better manage your budget.",
        // image: "assets/spending.png",
        // Ensure you have this asset in your images folder
        color: Colors.blueAccent),
    buildPage(
        title: "Budget Smarter",
        text:
            "Set budgets for different categories and monitor your spending habits.",
        // image: "assets/budget.png",
        color: Colors.blueAccent),
    buildPage(
        title: "Financial Insights",
        text:
            "Gain insights into your financial health with detailed reports and graphs.",
        // image: "assets/insights.png",
        color: Colors.blueAccent),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page == pages.length - 1) {
        // Optionally add a delay if you want some time before transitioning
        Future.delayed(Duration(seconds: 2), () {
          navigateToHomePage();
        });
      }
    });
  }

  void navigateToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FormScreen()));
  }

  static Widget buildPage(
          {required String title,
          required String text,
          // required String image,
          required Color color}) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/wallet.svg',
              height: 200,
            ),
            SizedBox(height: 20),
            // Image.asset(image, height: 200), // Display the image
            SizedBox(height: 20),
            Text(title,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueGrey,
                        ),
                        height: 80.0,
                        width: 80.0,
                        child: const Center(
                          child: Text(
                            'Skip',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[index],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _controller,
              // Connect the dot indicator to the controller
              count: pages.length,
              effect: WormEffect(),
              // Choose the effect you like
              onDotClicked: (index) => _controller.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

