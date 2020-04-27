import 'package:flutter/material.dart';
import 'package:animated_button/ui/Cards.dart';

class sliders extends StatefulWidget {
  @override
  _slidersState createState() => _slidersState();
}

class _slidersState extends State<sliders> with SingleTickerProviderStateMixin {
  List _mails = ["Mail2", "Mail", "Mail23"];
  final _mykey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height / 2,
      width: _screenSize.width * 5 / 6,
      child: AnimatedList(
          key: _mykey,
          initialItemCount: _mails.length,
          itemBuilder: (context, index, animation) {
            return Container(
              height: 100,
              child: cards(
                mails: _mails[index],
                delete: (){
                  _mykey.currentState.removeItem(index, (context, animation) => null);
                  var abc =_mails.removeAt(index);
                },
              ),
            );
          }),
    );
  }
}
