import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/functions/group_setting_fun.dart';





class BlockedList extends StatefulWidget {

  final String title;
  BlockedList(this.title);

  @override
  _BlockedListState createState() => _BlockedListState();
}

class _BlockedListState extends State<BlockedList> {

  bool _isLoading = false;
  FunFun _funFun = new FunFun();
  GroupSettingFun _groupSettingFun = new GroupSettingFun();





  Widget listTitle(Icon icon, Text text, String uid) {
    return ListTile(onTap: () async{
      Navigator.of(context).pop();
      await _unBlock(uid);
    }, leading: icon, title: text);
  }


  Future _unBlock(String uid) async{
    await _groupSettingFun.unBlock(widget.title, uid);
  }



  Widget _blockedMemberWidget(String uid){

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(bottom: 20)),
        listTitle(
            Icon(Icons.delete, color: Colors.white70, size: 28),
            Text(
              'Unblock this user',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          uid
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('groups').doc(widget.title).collection('block_list').snapshots(),

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
                        padding: EdgeInsets.only(top: 15),
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
                                builder: (context) =>  _blockedMemberWidget(docs[index].id));
                          },

                          child: Card(
                            color: Colors.white.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30))
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
                        ),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.only(top: 15),
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
                              builder: (context) =>  _blockedMemberWidget(docs[index].id));
                        },

                        child: Card(
                          color: Colors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30))
                          ),
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
                      ),
                    );
                  }
              );
            }

        );
      },
    );

  }


}

/*
 return Padding(
                padding: EdgeInsets.only(top: 15),
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
                        builder: (context) =>  _blockedMemberWidget());
                  },

                  child: Card(
                    color: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(30))
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.red,
                        ),
                        Padding(padding: EdgeInsets.only(left: 15)),
                        Text(
                          'Ahmed Mohamed',
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
 */
