import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/chat_fun.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/functions/make_group_fun.dart';



class GroupChatWidget extends StatefulWidget {

  final String title;

  GroupChatWidget(this.title);

  @override
  _GroupChatWidgetState createState() => _GroupChatWidgetState();
}

class _GroupChatWidgetState extends State<GroupChatWidget> {


  TextEditingController _newMsg = new  TextEditingController();
  MakeGroupFun _makeGroupFun = new MakeGroupFun();
  FunFun _funFun = new FunFun();

  
  
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40)
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              onChanged: (value){},
              controller: _newMsg,
              cursorColor: Colors.yellowAccent,
              maxLines: null,
              style: TextStyle(fontSize: 20, color: Colors.yellowAccent, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintStyle:  TextStyle(fontSize: 20, color: Colors.yellowAccent.withOpacity(0.4)),
                hintText: 'Send new Message',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 64,
          width: 50,
          child: FlatButton(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100)),
              ),
              color: Colors.white.withOpacity(0.15),
              onPressed: () async {
                if (_funFun.isTyping(_newMsg.text)) {
                  String msg = _funFun.string;
                  _newMsg.clear();
                  await _makeGroupFun.sendMessage(widget.title, msg);
                }
              },
              child: Center(
                  child: Icon(Icons.keyboard_arrow_right,
                      size: 40, color: Colors.yellowAccent))),
        ),
        Padding(padding: EdgeInsets.only(left: 10)),
        SizedBox(
          height: 60,
          width: 60,
          child: FlatButton(
              highlightColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100), // <-- Radius
              ),
              color: Colors.yellowAccent.withOpacity(0.6),
              onPressed: () {},
              child: Center(
                  child: Icon(Icons.mic,
                      size: 30,
                      color: Theme.of(context).primaryColor))),
        ),
      ],
    );

  }


}
