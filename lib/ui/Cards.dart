import 'package:flutter/material.dart';

class cards extends StatefulWidget {
  final String mails;
  Function tick;
  Function archive;
  Function delete;

  cards({this.mails, this.tick, this.archive, this.delete});

  @override
  _cardsState createState() => _cardsState();
}

class _cardsState extends State<cards> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var initial_p = 0.0;
  var final_p = 0.0;

  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _controller.value = 1.00;
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Stack(
          children: <Widget>[
            Container(
              width: _screenSize.width * 5 / 6,
              height: _screenSize.height / 4,
              color: Colors.white70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.greenAccent,
                      ),
                      onPressed: widget.tick),
                  IconButton(
                      icon: Icon(Icons.archive),
                      color: Colors.black,
                      onPressed: widget.archive),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    onPressed: widget.delete,
                  )
                ],
              ),
            ),
            Container(
              width: _screenSize.width * 5 / 6,
              height: _screenSize.height / 4,
              child: FractionallySizedBox(
                widthFactor: _controller.value,
                alignment: Alignment.centerLeft,
                heightFactor: 1,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Stack(
                    children: [
                      Text(widget.mails),
                      GestureDetector(
                        onDoubleTap: () {},
                        onHorizontalDragStart: (dragdetails) {
                          setState(() {
                            initial_p = dragdetails.localPosition.dx;
                          });
                        },
                        onHorizontalDragUpdate: (dragdetails) {
                          final widgetsize = _screenSize.width * 5 / 6;
                          final mintostart = 0.1 * widgetsize;
                          print(mintostart.toString() + "a");
                          if (initial_p >= mintostart) {
                            setState(() {
                              print(mintostart.toString() + "a");
                              final_p = dragdetails.localPosition.dx;
                            });
                          }
                          ;
                        },
                        onHorizontalDragEnd: (dragend) async {
                          final drags = initial_p - final_p;
                          final widgetsize = _screenSize.width * 1 / 4;
                          final percent = widgetsize * 0.5;
                          print(initial_p.toString() +
                              " " +
                              final_p.toString() +
                              " " +
                              drags.toString() +
                              " " +
                              percent.toString());
                          if (drags > percent) {
                            _controller.animateTo(0.55,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          } else {
                            _controller.animateTo(1,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
