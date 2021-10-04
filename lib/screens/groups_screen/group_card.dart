import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/make_group_fun.dart';
import 'package:kaito/screens/groups_screen/group_chat/group_chat_screen.dart';




class GroupCard extends StatefulWidget {

  final Color color;
  final String imageUrl;
  final String title;
  final String interest;
  final int members;
  final bool isOwner;
  final Timestamp date;

  GroupCard(this.color, this.imageUrl, this.title, this.interest, this.members, this.isOwner, this.date);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {

  MakeGroupFun _makeGroupFun = new MakeGroupFun();



  Widget details(String string, Color color){
    return Text(
      string,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'comfortaa',
      ),
    );
  }

  Widget expansionTile(){

    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            topLeft: Radius.circular(100)
          )
        ),

        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            details('${widget.title}', Colors.yellowAccent.withOpacity(0.8)),
            Padding(padding: EdgeInsets.only(bottom: 30)),

            details('${widget.interest}', Colors.yellowAccent.withOpacity(0.8)),
            Padding(padding: EdgeInsets.only(bottom: 30)),

            details('${widget.members} online now', Colors.yellowAccent.withOpacity(0.8)),
            Padding(padding: EdgeInsets.only(bottom: 10)),

          ],
        ),
      ),
    );

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await Navigator.push(context,
            MaterialPageRoute(
                builder: (_) => GroupChatScreen(widget.title, widget.interest, widget.imageUrl, widget.isOwner, widget.date, widget.color)));
      },
      child: Container(
        width: 340,
        height: 200,
        decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.imageUrl),
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            Opacity(
              opacity: 0.3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(30)),
              ),
            ),

            Opacity(
              opacity: 0.3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: widget.color == Colors.white?
                    widget.color.withOpacity(0):
                    widget.color,
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                        fontFamily: 'comfortaa'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),


            SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton(
                    onPressed: () async{
                      await showModalBottomSheet(
                        //isScrollControlled: true,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => expansionTile());
                      /*
                      setState(() {
                        _isExpansion = true;
                      });

                       */
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ))),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.yellowAccent.withOpacity(0.4))),
                    child: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.black,
                      size: 50,
                    ))),

          ],
        ),
      ),
    );
  }
}
