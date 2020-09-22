

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'components/custompaint.dart';
import 'components/onbo_page.dart';
import 'components/provider.dart';


class Onboarding extends StatelessWidget{
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: onboardData.length,
          itemBuilder: (context, index) {
            return OnboardPage(
              pageController: pageController,
              pageModel: onboardData[index],
            );
          },
        ),



        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 40),
            child: PageViewIndicator(
              controller: pageController,
              itemCount: onboardData.length,
              color: colorProvider.color,
            ),
          ),
        )

      ],


    );
  }
}

List<OnboardPageModel> onboardData  = [
  OnboardPageModel(
    Color(0xFFE6E6E6),
    Color(0xFF005699),
    Color(0xFFFFE074),
    2,
    'assets/8.png',
    "Explore",
      "Explore the services you require.Get familiar with our pool of services",

  ),
  OnboardPageModel(
    Color(0xFF005699),
    Color(0xFFFFE074),
    Color(0xFF39393A),
    2,
    'assets/8.png',
    "Schedule",
    "Select  the  time  slot, get your\n appointment booked."
        "\nWe give the best price in market,\n we guarantee!",
  ),
  OnboardPageModel(
    Color(0xFFFFE074),
    Color(0xFF39393A),
    Color(0xFFE6E6E6),
    0,
    'assets/8.png',
    "Tracks",
    "Get real time update of the service."
        "\nProfessional crew and services",
  ),
  OnboardPageModel(
    Color(0xFF39393A),
    Color(0xFFE6E6E6),
    Color(0xFF005699),
    1,
    'assets/8.png',
    'Get Your Job Done',
    "Get satisfied with your "
        "requirement fulfilled",
  ),
];