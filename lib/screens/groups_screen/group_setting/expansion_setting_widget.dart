import 'package:flutter/material.dart';




class ExpansionSettingWidget extends StatefulWidget {

  final String title;
  final IconData icon;
  final List<Widget> list;
  ExpansionSettingWidget(this.title, this.icon, this.list);


  @override
  _ExpansionSettingWidgetState createState() => _ExpansionSettingWidgetState();


}

class _ExpansionSettingWidgetState extends State<ExpansionSettingWidget> {

  bool _onExpansionChanged = false;

  @override
  Widget build(BuildContext context) {

    return ExpansionTile(

      onExpansionChanged: (onExpansionChanged){
        setState(() {
          _onExpansionChanged = onExpansionChanged;
        });
        print(_onExpansionChanged);
      },

      children: widget.list,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
                color: _onExpansionChanged?Colors.yellowAccent.withOpacity(0.8):Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'comfortaa'
            ),
          ),
          Icon(widget.icon, color: _onExpansionChanged?Colors.yellowAccent.withOpacity(0.8):Theme.of(context).textTheme.bodyText1?.color)
        ],
      ),
    );

  }

}
