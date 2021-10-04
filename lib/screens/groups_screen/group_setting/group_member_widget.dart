import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/functions/group_setting_fun.dart';





class GroupMemberWidget extends StatefulWidget {
  
  final String title;
  GroupMemberWidget(this.title);
  
  @override
  _GroupMemberWidgetState createState() => _GroupMemberWidgetState();
}

class _GroupMemberWidgetState extends State<GroupMemberWidget> {


  bool _isLoading = false;
  FunFun _funFun = new FunFun();
  GroupSettingFun _groupSettingFun = new GroupSettingFun();


  Widget listTitle(Icon icon, Text text, Function() func) {
    return ListTile(onTap: func, leading: icon, title: text);
  }

  Future dialog(String msg, double size, String uid, ){

    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // <-- Radius
        ),
        backgroundColor: Colors.yellowAccent,
        title: Text(msg,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: size,
                fontWeight: FontWeight.bold
            )),
        content:
        Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Divider(
                thickness: 2.5,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 7,
              ),

              SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child:  FlatButton(
                          highlightColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => _makeUserCantChat(uid),
                          color: Theme.of(context).primaryColor,
                          child: Text('Yes', style:
                          TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          )),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      SizedBox(
                        width: 100,
                        child:  FlatButton(
                          highlightColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () async{

                            setState(() {
                              _isLoading = true;
                            });

                            Navigator.of(context).pop();
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text('No', style:
                          TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          )),
                        ),
                      )
                    ],
                  )
              )

            ],
          ),
        )

    );

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Opacity(child: alert , opacity: 0.699999);
        });
  }

  Future _makeUserCantChat (String uid) async {
    setState(() {
      _isLoading = true;
    });

    Navigator.of(context).pop();
    await _groupSettingFun.addUserToBlockMembers(widget.title, uid);
    print('THIS JOOOOOOOOOOOOOOOOKE');
  }


  Widget groupMemberWidgetSheet(String uid){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(bottom: 20)),
        listTitle(
            Icon(Icons.delete, color: Colors.white70, size: 28),
            Text(
              'Make this user cannot chatting',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ), () async {
          await dialog(
              'Are you sure uou want make this user cannot chatting in this group again.\n'
                  'Tip: In this case this user will see the chat but he will not reply',
              15,
              uid,
          );
          if(_isLoading) {
            Navigator.pop(context);
          }
        }),
        Padding(padding: EdgeInsets.only(top: 20)),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return
      StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('groups').doc(widget.title).collection('members').snapshots(),
      builder: (ctx, snapShot){

        if(snapShot.connectionState == ConnectionState.waiting){
          return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
        }
        final docs = snapShot.data!.docs;

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (ctx, index){
            return FutureBuilder<List>(


                future: FirebaseFirestore.instance.collection('users').doc(docs[index].id)
                    .get().then((value) {
                  return [value.get('name'), value.get('color')];}),

                builder: (ctx, snapShot){

                  if(snapShot.connectionState == ConnectionState.waiting){
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(30)
                            )
                        ),

                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white,
                            ),
                            Padding(padding: EdgeInsets.only(left: 15)),
                            Text(
                              'User',
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1?.color,
                                  fontSize: 20
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(30)
                          )
                      ),
                      highlightColor: Colors.white,
                      onPressed: (){},
                      onLongPress: () async{
                        await showModalBottomSheet(
                          //isScrollControlled: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) =>  groupMemberWidgetSheet(docs[index].id));
                      },

                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: _funFun.getColor(snapShot.data?[1]),
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          Text(
                            snapShot.data?[0],
                            style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1?.color,
                                fontSize: 20
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          },
        );
      },
    );

  }


}
