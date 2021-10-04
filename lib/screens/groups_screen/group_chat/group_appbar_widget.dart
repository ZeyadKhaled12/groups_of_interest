import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/make_group_fun.dart';
import 'package:kaito/providers/user_details.dart';
import '../group_setting/group_setting.dart';
import 'package:provider/provider.dart';




class GroupAppBarWidget extends StatefulWidget {

  final String title;
  final String interest;
  final String imageUrl;
  final bool isFav;
  final bool isOwner;
  final Timestamp date;
  final Color color;
  final Key? key;
  GroupAppBarWidget(this.title, this.interest, this.imageUrl, this.isFav, this.isOwner, this.date, this.color, {this.key});

  @override
  _GroupAppBarWidgetState createState() => _GroupAppBarWidgetState();


}

class _GroupAppBarWidgetState extends State<GroupAppBarWidget> {

  bool _colorOfDelete = false;
  MakeGroupFun _makeGroupFun = new MakeGroupFun();

  bool _isFav = true;
  bool _isAnythingClicked = false;




  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        widget.isOwner?
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          SizedBox(
            width: 60,
            child: FlatButton(
                highlightColor: Colors.yellowAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () {
                  setState(() {
                    _colorOfDelete = false;
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIsDeleteFalseGroup();
                    print(Provider.of<UserDetails>(context, listen: false)
                        .isDeleteGroup);
                  });
                },
                onLongPress: () {
                  setState(() {
                    _colorOfDelete = !_colorOfDelete;
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIsDeleteGroup();
                    print(Provider.of<UserDetails>(context, listen: false)
                        .isDeleteGroup);
                  });
                },
                color: _colorOfDelete
                    ? Colors.yellowAccent
                    : Colors.yellowAccent.withOpacity(0.5),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                )),
          ),
        ]):
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[

          SizedBox(
            width: 60,
            child: FlatButton(
                highlightColor: Colors.yellowAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () {
                  setState(() {
                    _isAnythingClicked = true;
                  });
                  _makeGroupFun.deleteGroupFav(widget.title, context);
                  setState(() {
                    _isFav = false;
                  });

                },

                onLongPress: () async{
                  setState(() {
                    _isAnythingClicked = true;
                  });
                  await _makeGroupFun.addGroupFav(widget.title, context);
                  setState(() {
                    _isFav = true;
                  });
                },

                color: _isAnythingClicked?
                    _isFav?
                        Colors.yellowAccent:
                        Colors.yellowAccent.withOpacity(0.5):
                    widget.isFav?
                        Colors.yellowAccent:
                        Colors.yellowAccent.withOpacity(0.5),
                child: Icon(
                  Icons.star,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                )),
          ),

          Padding(padding: EdgeInsets.only(right: 9)),

          SizedBox(
            width: 60,
            child: FlatButton(
                highlightColor: Colors.yellowAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () {
                  setState(() {
                    _colorOfDelete = false;
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIsDeleteFalseGroup();
                    print(Provider.of<UserDetails>(context, listen: false)
                        .isDeleteGroup);
                  });
                },
                onLongPress: () {
                  setState(() {
                    _colorOfDelete = !_colorOfDelete;
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIsDeleteGroup();
                    print(Provider.of<UserDetails>(context, listen: false)
                        .isDeleteGroup);
                  });
                },
                color: _colorOfDelete
                    ? Colors.yellowAccent
                    : Colors.yellowAccent.withOpacity(0.5),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                )),
          ),
        ]),
        widget.isOwner?
        Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30)
                )
              ),
              highlightColor: Theme.of(context).textTheme.bodyText1?.color,
              onPressed: () async{
                await Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => GroupSetting(widget.title, widget.imageUrl, widget.date, widget.color)));
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('${widget.title}',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.yellowAccent,
                                fontWeight: FontWeight.bold)),
                        widget.isOwner?
                        Text('Click here to go setting',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.yellowAccent.withOpacity(0.68),
                                fontWeight: FontWeight.bold)):
                        Text('${widget.interest}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellowAccent.withOpacity(0.68),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(widget.imageUrl),
                    ),
                  ]),
            )):
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('${widget.title}',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold)),
                      Text('${widget.interest}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.yellowAccent.withOpacity(0.68),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                ]))
      ],
    );
  }
}
