import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/screens/groups_screen/make_group/make_group_widget_first.dart';
import 'package:kaito/screens/groups_screen/make_group/make_group_widget_second.dart';




class MakeGroup extends StatefulWidget {
  @override
  _MakeGroupState createState() => _MakeGroupState();
}

class _MakeGroupState extends State<MakeGroup> {

  TextEditingController _titleGroup = new TextEditingController();
  TextEditingController _interestGroup = new TextEditingController();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/make_group_image.jpg'),
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0),
                    Theme.of(context).primaryColor,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                )
              ),
            ),
            MakeGroupWidgetFirst()


          ],
        )
      ),
    );
  }


}
