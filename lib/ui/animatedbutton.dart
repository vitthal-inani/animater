import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  @override
  final String initialtext, finaltext;
  final ButtonStyle buttonStyle;
  final IconData icon;
  final double iconsize;
  final Duration animationduration;
  final Function onTap;

  AnimatedButton({
    this.initialtext,
    this.finaltext,
    this.buttonStyle,
    this.icon,
    this.iconsize,
    this.animationduration,
    this.onTap,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ButtonStates _currentstate;
  Duration _smallDuration;

  @override
  void initState() {
    super.initState();
    _smallDuration = Duration(
        milliseconds: (widget.animationduration.inMilliseconds * 0.2).round());
    _controller =
        AnimationController(vsync: this, duration: widget.animationduration);
    _currentstate = ButtonStates.ONLY_TEXT;
    _controller.addListener(() {
      double controllerValue = _controller.value;
      if (controllerValue < 0.4) {
        setState(() {
          _currentstate = ButtonStates.ONLY_ICON;
        });
      } else {
        setState(() {
          _currentstate = ButtonStates.BOTH;
        });
      }
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      shape: (_currentstate == ButtonStates.ONLY_ICON)
          ? CircleBorder(
              side: BorderSide(width: 30, color: Colors.transparent),
            )
          : null,
      borderRadius: (_currentstate != ButtonStates.ONLY_ICON)
          ? BorderRadius.all(Radius.circular(3.00))
          : null,
      color: (_currentstate == ButtonStates.ONLY_TEXT)
          ? widget.buttonStyle.intialc
          : widget.buttonStyle.finalc,
      child: InkWell(
        onTap: () {
          _controller.forward();
          widget.onTap();
        },
        child: AnimatedContainer(
          duration: _smallDuration,
          height: widget.iconsize + 32,
          decoration: BoxDecoration(
            color: (_currentstate == ButtonStates.ONLY_TEXT)
                ? widget.buttonStyle.intialc
                : widget.buttonStyle.finalc,
            border: Border.all(
                color: (_currentstate == ButtonStates.ONLY_TEXT)
                    ? Colors.transparent
                    : widget.buttonStyle.finalc),
            shape: (_currentstate == ButtonStates.ONLY_ICON)
                ? BoxShape.circle
                : BoxShape.rectangle,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.00, vertical: 10.00),
          child: AnimatedSize(
            vsync: this,
            duration: _smallDuration,
            curve: Curves.easeInOut,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (_currentstate != ButtonStates.ONLY_TEXT)
                    ? Icon(
                        widget.icon,
                        size: widget.iconsize,
                        color: widget.buttonStyle.finalts.color,
                      )
                    : Container(),
                (_currentstate == ButtonStates.ONLY_TEXT)
                    ? Text(
                        widget.initialtext,
                        style: widget.buttonStyle.intialts,
                      )
                    : Container(),
                SizedBox(
                  width: (_currentstate == ButtonStates.BOTH) ? 20 : 0,
                ),
                (_currentstate == ButtonStates.BOTH)
                    ? Text(
                        widget.finaltext,
                        style: widget.buttonStyle.finalts,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonStyle {
  final TextStyle intialts, finalts;
  final Color intialc, finalc;
  final double elevation, borderradius;

  ButtonStyle(
      {this.intialts,
      this.finalts,
      this.intialc,
      this.finalc,
      this.elevation,
      this.borderradius});
}

enum ButtonStates {
  ONLY_TEXT,
  ONLY_ICON,
  BOTH,
}
