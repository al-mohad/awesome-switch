library awesome_switch;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum _SwitchType { DEFAULT, YESNO, ONOFF, BG }

class AwesomeSwitch extends StatefulWidget {
  final bool value;

  final ValueChanged<bool> onChange;
  final Color activeColor;
  final Color inactiveColor;
  final IconData activeIcon;

  final String activeBG;
  final String inactiveBG;
  final _SwitchType _switchType;

  const AwesomeSwitch({
    Key key,
    @required this.value,
    @required this.onChange,
    this.activeColor,
    this.activeIcon,
    this.inactiveColor,
    this.activeBG,
    this.inactiveBG,
  }) : _switchType = _SwitchType.DEFAULT;
  const AwesomeSwitch.yesNo({
    Key key,
    @required this.value,
    @required this.onChange,
    this.activeColor,
    this.activeIcon,
    this.inactiveColor,
    this.activeBG,
    this.inactiveBG,
  }) : _switchType = _SwitchType.YESNO;
  const AwesomeSwitch.onOff({
    Key key,
    @required this.value,
    @required this.onChange,
    this.activeColor,
    this.activeIcon,
    this.inactiveColor,
    this.activeBG,
    this.inactiveBG,
  }) : _switchType = _SwitchType.ONOFF;
  const AwesomeSwitch.bg({
    Key key,
    this.value,
    this.onChange,
    this.activeColor,
    this.activeIcon,
    this.inactiveColor,
    @required this.activeBG,
    @required this.inactiveBG,
  }) : _switchType = _SwitchType.BG;
  @override
  _AwesomeSwitchState createState() => _AwesomeSwitchState();
}

class _AwesomeSwitchState extends State<AwesomeSwitch>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;
  // Text Animations
  Animation<Offset> _animationSlide;
  AnimationController _textAnimationController;
  Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 120), vsync: this);
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut));
  }

  Widget buildBGSwitch() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChange(true)
                : widget.onChange(false);
          },
          child: Container(
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: widget.value
                    ? AssetImage(widget.activeBG)
                    : AssetImage(widget.inactiveBG),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circleAnimation.value == Alignment.centerRight
                    ? Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 0.0),
                      )
                    : Container(),
                Align(
                  alignment: _circleAnimation.value,
                  child: Container(
                    width: 30.0,
                    height: 35.0,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: widget.activeColor ?? Colors.black12,
                        blurRadius: 9.0,
                        spreadRadius: 3.0,
                      ),
                    ], shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
                _circleAnimation.value == Alignment.centerLeft
                    ? Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 5.0),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildONOFFSwitch() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                if (_animationController.isCompleted) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                widget.value == false
                    ? widget.onChange(true)
                    : widget.onChange(false);
              },
              child: Container(
                width: 65.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: _circleAnimation.value == Alignment.centerLeft
                      ? widget.inactiveColor ?? Colors.red
                      : widget.activeColor ?? Colors.green,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _circleAnimation.value == Alignment.centerRight
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 35.0),
                            child: Container(),
                          )
                        : Container(),
                    Align(
                      alignment: _circleAnimation.value,
                      child: Container(
                        width: 30.0,
                        height: 35.0,
                        decoration: BoxDecoration(boxShadow: [
                          _circleAnimation.value == Alignment.centerRight
                              ? BoxShadow(
                                  color: widget.activeColor ?? Colors.green,
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                )
                              : BoxShadow(
                                  color: widget.inactiveColor ?? Colors.red,
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                ),
                        ], shape: BoxShape.circle, color: Colors.white),
                        child: AnimatedDefaultTextStyle(
                          style: _circleAnimation.value == Alignment.centerLeft
                              ? TextStyle(
                                  fontSize: 28,
                                  color: widget.inactiveColor ?? Colors.red,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 28.0,
                                  color: widget.activeColor ?? Colors.green,
                                  fontWeight: FontWeight.w100),
                          duration: const Duration(milliseconds: 200),
                          child: Center(child: Text("O")),
                          curve: Curves.bounceInOut,
                        ),
                      ),
                    ),
                    _circleAnimation.value == Alignment.centerLeft
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 35.0),
                            child: Container(),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5.0),
            AnimatedDefaultTextStyle(
              style: _circleAnimation.value == Alignment.centerLeft
                  ? TextStyle(
                      fontSize: 28,
                      color: widget.inactiveColor ?? Colors.red,
                      fontWeight: FontWeight.bold)
                  : TextStyle(
                      fontSize: 28.0,
                      color: widget.activeColor ?? Colors.green,
                      fontWeight: FontWeight.w100),
              duration: const Duration(milliseconds: 200),
              child: Text(
                  _circleAnimation.value == Alignment.centerLeft ? "FF" : "N"),
              curve: Curves.easeInToLinear,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  Widget buildYesNoSwitch() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChange(true)
                : widget.onChange(false);
          },
          child: Container(
            width: 70.0,
            height: 35.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _circleAnimation.value == Alignment.centerLeft
                    ? widget.inactiveColor ?? Colors.grey
                    : widget.activeColor ?? Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        _circleAnimation.value == Alignment.centerRight
                            ? CupertinoIcons.checkmark_alt
                            : CupertinoIcons.nosign,
                        color: _circleAnimation.value == Alignment.centerRight
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 5.0),
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDefaultSwitch() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChange(true)
                : widget.onChange(false);
          },
          child: Container(
            width: 70.0,
            height: 35.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _circleAnimation.value == Alignment.centerLeft
                    ? Colors.grey
                    : widget.activeColor),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            'On',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 5.0),
                          child: Text(
                            'Off',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget._switchType) {
      case _SwitchType.YESNO:
        return buildYesNoSwitch();
        break;
      case _SwitchType.ONOFF:
        return buildONOFFSwitch();
        break;
      case _SwitchType.BG:
        return buildBGSwitch();
        break;
      default:
        return buildDefaultSwitch();
        break;
    }
  }
}
