import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaito/functions/group_setting_fun.dart';
import 'package:kaito/screens/groups_screen/group_setting/blocked_list.dart';
import 'package:kaito/screens/groups_screen/group_setting/change_color_image.dart';
import 'package:kaito/screens/groups_screen/group_setting/expansion_setting_widget.dart';
import 'package:kaito/screens/groups_screen/group_setting/group_member_widget.dart';
import 'package:kaito/screens/groups_screen/group_setting/groupst_change_image.dart';




class GroupSetting extends StatefulWidget {

  final String title;
  final String imageUrl;
  final Timestamp date;
  final Color color;
  GroupSetting(this.title, this.imageUrl, this.date, this.color);

  @override
  _GroupSettingState createState() => _GroupSettingState();

}

class _GroupSettingState extends State<GroupSetting> {

  GroupSettingFun _groupSettingFun = new GroupSettingFun();


  Future dialog(String msg, double size, int i){
    bool _isLoading = false;

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
                          onPressed: i == 0?() async{Navigator.of(context).pop(); await _groupSettingFun.clearChat(widget.title);}:
                          () async{

                            setState(() {
                              _isLoading = true;
                            });

                            await _groupSettingFun.removeGroup(context, widget.title);
                            Navigator.of(context).pop();


                            },
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text('No', style:
                          TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          )),
                        ),
                      ),
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


  Widget _listTile(String title, Icon icon, int i) {

    return ListTile(
      onTap: i == 0? () => clearChat(): () => removeGroup(),
      title:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Color(0XFFEF697A),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'comfortaa'
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 38),
              child: icon)
        ],
      ),
    );

  }

  Future clearChat() async{

    return dialog('Are you sure that you  want clear the chat of this group', 18, 0);
  }

  Future removeGroup() async{
    return dialog('Are you sure that you want remove this group', 18, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.2),
      body: RefreshIndicator(
        color:  Colors.yellowAccent,
        backgroundColor:Theme.of(context).primaryColor,
        onRefresh: () async{
          setState(() {});
        },
        child: Container(

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Stack(
                  alignment: Alignment.bottomLeft,
                  //fit: StackFit.loose,
                  children: [
                    Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.imageUrl)))),

                    Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.3)
                        )),

                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${widget.title}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 44,
                                color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'comfortaa'
                            ),
                          ),
                          Text(
                            'Created at ${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.date.millisecondsSinceEpoch))}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.yellowAccent,
                                fontFamily: 'comfortaa'
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),

                Container(

                  color: Theme.of(context).primaryColor,

                    child: Column(
                      children: [
                        ExpansionSettingWidget('Change Image',  Icons.photo, [GroupstChangeImage(widget.title)]),

                        ExpansionSettingWidget('Change Color of image',  Icons.color_lens, [ChangeColorImage(widget.title, widget.color, widget.imageUrl)]),
                      ],
                    ),
                  ),
                Padding(padding: EdgeInsets.only(bottom: 15)),


                Container(

                  color: Theme.of(context).primaryColor,

                  child: ExpansionSettingWidget('Blocked List',  Icons.block, [BlockedList(widget.title)]),
                ),

                Container(
                  //width: double.infinity,
                  //height: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: ExpansionSettingWidget('Online members now', Icons.people, [Stack(
                    children: [
                      //Padding(padding: EdgeInsets.only(top: 15)),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FutureBuilder(

                          future: FirebaseFirestore.instance.collection('groups').doc(widget.title).get().then((value) {
                            return value.get('number');
                          }),

                          builder: (ctx, snapShot){
                            return Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                '${snapShot.data} Members now',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.yellowAccent.withOpacity(0.8),
                                    fontFamily: 'comfortaa',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },


                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: SingleChildScrollView(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[



                              GroupMemberWidget(widget.title),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),])
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),

                Container(

                  color: Theme.of(context).primaryColor,

                  child: Column(
                    children: [

                      _listTile('Clear the chat of this group', Icon(Icons.clear, color: Color(0XFFEF697A)), 0),

                      _listTile('Remove this group', Icon(Icons.delete_forever, color: Color(0XFFEF697A)), 1),
                    ],
                  ),
                ),




              ],
            ),
          ),

        ),
      ),
    );
  }

}
