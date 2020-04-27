import 'package:flutter/material.dart';
import './ui/animatedwidget.dart';
import 'package:animated_button/ui/animatedbutton.dart' as button;
import 'package:animated_button/ui/animated_button.dart' as ab;
import 'ui/sliderlist.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ab.AnimatedButton(
              animationduration: Duration(seconds: 3),
              iconsize: 30,
              onTap: () {
                print("okay");
              },
              icon: Icons.check,
              initialtext: Text("Press here",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              finaltext: Text("Correct",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              buttonStyle: ab.ButtonStyle(
                intialColour: Colors.blue,
                finalColour: Colors.green,
                elevation: 10,
                borderradius: 40,
              ),
            ),
            sliders(),
          ],
        )),
      ),
    );
  }
}
