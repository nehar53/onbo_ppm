import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onbo_ppm/components/provider.dart';

import 'package:provider/provider.dart';

import 'custompaint.dart';

class OnboardPage extends StatefulWidget {
  final PageController pageController;
  final OnboardPageModel pageModel;

  const OnboardPage(
      {Key key, @required this.pageModel, @required this.pageController})
      : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> heroAnimation;
  Animation<double> borderAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    heroAnimation = Tween<double>(begin: -40, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    borderAnimation = Tween<double>(begin: 75, end: 50).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    animationController.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _nextButtonPressed() {
    Provider.of<ColorProvider>(context).color =
        widget.pageModel.nextAccentColor;
    widget.pageController.nextPage(
      duration: Duration(
        milliseconds: 100,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
  _backButtonPressed() {
    Provider.of<ColorProvider>(context).color =
        widget.pageModel.nextAccentColor;
    widget.pageController.previousPage(
      duration: Duration(
        milliseconds: 100,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: widget.pageModel.primeColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AnimatedBuilder(
                animation: heroAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(heroAnimation.value, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Image.asset(widget.pageModel.imagePath,
                      height: 300,
                      width: 300,),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          widget.pageModel.caption,
                          style: TextStyle(
                              fontSize: 24,
                              color:
                              widget.pageModel.accentColor.withOpacity(0.8),
                              letterSpacing: 1,
                              fontStyle: FontStyle.normal),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          widget.pageModel.subhead,
                          style: TextStyle(
                            fontSize: 18,
                            color:
                            widget.pageModel.accentColor.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: borderAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: DrawerPaint(
                  curveColor: widget.pageModel.accentColor,
                ),
                child: Container(
                  width: borderAnimation.value,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                          size: 32,
                        ),
                        onPressed: _nextButtonPressed,
                      ),
                    ),
                  ),

                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 32,
              ),
              onPressed: _backButtonPressed,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 24,top: 24),
            child:  Text(
              'Skip',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
            ),
          ),
        )
      ],
    );
  }
}


class PageViewIndicator extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final Color color;

  const PageViewIndicator({
    Key key,
    @required this.controller,
    @required this.itemCount,
    this.color,
  }) : super(key: key);

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndicatorPainter(
        4,
        widget.controller.page?.round() ?? -1,
        color: widget.color,
      ),
      child: Container(
        width: 60,
        height: 10,
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final Color color;
  final int length;
  final int currentIndicator;

  Paint dotPaint;
  static const double _smallDot = 4;
  static const double _bigDot = 7;

  IndicatorPainter(this.length, this.currentIndicator,
      {this.color = Colors.black})
      : dotPaint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas, 0, Offset(0, size.height / 2));
    _drawCircle(canvas, 1, Offset(size.width / 3, size.height / 2));
    _drawCircle(canvas, 2, Offset(size.width / 3 * 2, size.height / 2));
    _drawCircle(canvas, 3, Offset(size.width, size.height / 2));
  }

  _drawCircle(Canvas canvas, int indicatorNumber, Offset offset) {
    (indicatorNumber == currentIndicator + 1)
        ? canvas.drawCircle(offset, _bigDot, dotPaint)
        : canvas.drawCircle(offset, _smallDot, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}