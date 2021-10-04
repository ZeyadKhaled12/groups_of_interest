import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/functions/group_setting_fun.dart';
import 'package:kaito/functions/make_group_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:provider/provider.dart';




class GroupMessageWidget extends StatefulWidget {

  final String message;
  final String uid;
  final bool isMe;
  final String name;
  final String color;
  final String id;
  final String title;
  final bool isOwner;


  GroupMessageWidget(this. title, this.message, this.uid, this.isMe, this.name, this.color, this.id, this.isOwner);


  @override
  _GroupMessageWidgetState createState() => _GroupMessageWidgetState();


}

class _GroupMessageWidgetState extends State<GroupMessageWidget> {

  FunFun _funFun = new FunFun();
  MakeGroupFun _makeGroupFun = new MakeGroupFun();
  GroupSettingFun _groupSettingFun = new GroupSettingFun();


  Widget listTitle(Icon icon, Text text, Function() func) {
    return ListTile(onTap: func, leading: icon, title: text);
  }



  Future dialog(){

    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        content:
        Container(
          //height: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              SizedBox(width: double.infinity,child:
              FlatButton(onPressed: () async{
                Navigator.pop(context);
                await _groupSettingFun.deleteMsgAdmin(widget.title, widget.id);

              },
                  highlightColor: Colors.white,
                  child: Text('Delete this message',
                      style:
                      TextStyle(fontSize: 19, fontFamily: 'comfortaa',
                          fontWeight: FontWeight.bold, color: Colors.yellowAccent)))),
              SizedBox(width: double.infinity, child: FlatButton(
                  highlightColor: Colors.white,
                  onPressed: () async{
                    Navigator.pop(context);
                    await _groupSettingFun.addUserToBlockAdmin(widget.title, widget.uid);
                  },
                  child: Text('Block this user', style:
              TextStyle(
                  fontSize: 25, fontFamily: 'comfortaa',
                  fontWeight: FontWeight.bold, color: Colors.yellowAccent)))),

            ],
          ),
        )

    );

    return showDialog(
        //barrierDismissible: true,
        context: context,
        builder: (context) {
          return Opacity(child: alert , opacity: 0.699999);
        });
  }


  @override
  Widget build(BuildContext context) {
    return
    widget.isMe?
    FlatButton(

      onPressed: () async{
        if(Provider.of<UserDetails>(context, listen: false).isDeleteGroup) {
          await _makeGroupFun.deleteMessage(widget.title, widget.id);
        }
      },

      onLongPress: () async{/*
        await showModalBottomSheet(
          //isScrollControlled: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) =>  btmsheet());

         */},

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Container(

              decoration: BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(0.58),//Theme.of(context).accentColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )

              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              child: Text(widget.message, style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          //Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    ):
    widget.isOwner?
    FlatButton(
      highlightColor: Colors.white,
      onPressed: (){},
      onLongPress: (){
        dialog();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 35,
            height: 35,
            child: CircleAvatar(
              backgroundColor: _funFun.getColor(widget.color),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )

              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name.length > 10?
                  '${widget.name.substring(0, 10)}....':
                  widget.name,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.58),
                          fontWeight: FontWeight.bold
                      )),
                  Text(widget.message, style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    ):
    FlatButton(
      //highlightColor: Colors.white,
      onPressed: (){},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 35,
            height: 35,
            child: CircleAvatar(
              backgroundColor: _funFun.getColor(widget.color),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )

              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name.length > 10?
                  '${widget.name.substring(0, 10)}....':
                  widget.name,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.58),
                          fontWeight: FontWeight.bold
                      )),
                  Text(widget.message, style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );


  }


}
