import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/group_setting_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/groups_screen/group_chat/group_appbar_widget.dart';
import 'package:kaito/screens/groups_screen/group_chat/group_chat_widget.dart';
import 'package:kaito/screens/groups_screen/group_chat/group_message_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class GroupChatScreen extends StatefulWidget {

  final String title;
  final String interest;
  final String imageUrl;
  final bool isOwner;
  final Timestamp date;
  final Color color;


  GroupChatScreen(this.title, this.interest, this.imageUrl, this.isOwner, this.date, this.color);


  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GroupSettingFun _groupSettingFun = new GroupSettingFun();


  Future startFun() async{
    await _groupSettingFun.addUserToMembers(widget.title);

    await Provider.of<UserDetails>(context, listen: false).changeGroupEntered(widget.title);

  }

  Future disposeFun() async{
    await _groupSettingFun.deleteUserToMembers(context, widget.title, true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('nullGroup', false);
   // Provider.of<UserDetails>(context, listen: false).nullGroupEnteredFun();
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<UserDetails>(context, listen: false).changeIsDeleteFalseGroup();
      print(widget.isOwner);
      if(!widget.isOwner){
        startFun();
      }
      print('\n\n\n\nGroup ChatScreen InitState\n\n\n\n\n');
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if(!widget.isOwner) {
      disposeFun();
    }

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
          automaticallyImplyLeading: false,
          title:  GroupAppBarWidget(widget.title, widget.interest, widget.imageUrl,
            Provider.of<UserDetails>(context, listen: false).listOfGroups.contains(widget.title),
            widget.isOwner, widget.date, widget.color
          )),


      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [

              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/groupchatImage.jpg')
                    )
                ),
              ),

              Container(
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).primaryColor.withOpacity(0.68),
              ),

              Container(
                padding: EdgeInsets.only(bottom: 75),
                child: StreamBuilder<QuerySnapshot>(

                  stream:
                  FirebaseFirestore.instance.collection('groups').doc(widget.title)
                      .collection('msg').orderBy('createdAt', descending: true)
                      .snapshots(),

                  builder: (ctx, snapShot){
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      );
                    }

                    final docs = snapShot.data!.docs;

                    return ListView.builder(
                      reverse: true,
                      itemBuilder: (ctx, index) {
                        return Padding(
                            padding: EdgeInsets.all(0),
                            child: GroupMessageWidget(
                                widget.title,
                                docs[index]['text'],
                                docs[index]['userId'],
                                docs[index]['userId'] == FirebaseAuth.instance.currentUser?.uid,
                                docs[index]['name'],
                                docs[index]['color'],
                                docs[index].id,
                                widget.isOwner
                            )
                        );
                      },
                      itemCount: docs.length,
                    );

                  }

                ),
              ),


              /*
              FutureBuilder<String>(
                future: FirebaseFirestore.instance.collection('groups').doc(widget.title).collection('block_list')
                  .doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
                    if(value.exists){
                      return 'Exist';
                    }
                    return 'NotExist';
                }),
                  builder: (ctx, snapShot){


                    if(snapShot.connectionState == ConnectionState.waiting){
                      return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
                    }


                    return snapShot.data == 'Exist'?
                    Container(
                      width: double.infinity,
                      color:Color(0XFFEF697A).withOpacity(0.4),
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'You can''t chatting in this group',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.yellowAccent,
                                  fontFamily: 'comfortaa',
                                  fontWeight: FontWeight.bold
                              )),
                          Text(
                              ' You are blocked from this group',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellowAccent,
                                  fontFamily: 'comfortaa',
                                  fontWeight: FontWeight.bold
                              )),
                          Padding(padding: EdgeInsets.only(top: 5))


                        ],
                      ),
                    ):
                    GroupChatWidget(widget.title);
                    
                  }
              ),
              
               */

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('groups').doc(widget.title).collection('block_list')
                      .snapshots(),
                  builder: (ctx, snapShot){


                    if(snapShot.connectionState == ConnectionState.waiting){
                      return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
                    }

                    List docs = [];

                    snapShot.data?.docs.forEach((element) {
                      docs.add(element.id);
                    });
                    return
                      docs.contains(FirebaseAuth.instance.currentUser?.uid)?
                      Container(
                      width: double.infinity,
                      color:Color(0XFFEF697A).withOpacity(0.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'You can''t chatting in this group',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.yellowAccent,
                                  fontFamily: 'comfortaa',
                                  fontWeight: FontWeight.bold
                              )),
                          Text(
                              ' You are blocked from this group',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellowAccent,
                                  fontFamily: 'comfortaa',
                                  fontWeight: FontWeight.bold
                              )),
                          Padding(padding: EdgeInsets.only(top: 5))


                        ],
                      ),
                    ):
                      GroupChatWidget(widget.title);

                  }
              )


            ],
          )
      ),
    );
  }



}
