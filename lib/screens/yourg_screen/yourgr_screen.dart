import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/groups_screen/group_card.dart';
import 'package:kaito/screens/groups_screen/make_group/make_group.dart';
import 'package:provider/provider.dart';




class YourgrScreen extends StatefulWidget {

  @override
  _YourgrScreenState createState() => _YourgrScreenState();

}

class _YourgrScreenState extends State<YourgrScreen> {

  FunFun _funFun = new FunFun();
  List docs = [];

  Future _refresh() async{
    await Provider.of<UserDetails>(context, listen: false).getYourGroups();
    setState(() {
      docs = Provider.of<UserDetails>(context, listen: false).yourGroups;
    });
  }
  Timestamp d= Timestamp.now();


  @override
  Widget build(BuildContext context) {

    docs = Provider.of<UserDetails>(context, listen: true).yourGroups;

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        elevation: 6,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MakeGroup()));
        },

        //return InviteScreen();
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 44,
        ),
        backgroundColor: Colors.yellowAccent.withOpacity(0.8),
      ),


      body: Container(
          padding: EdgeInsets.only(top: 20),
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: RefreshIndicator(
              color:  Colors.yellowAccent,
              backgroundColor:Theme.of(context).primaryColor,
              onRefresh: _refresh,
              child: docs.isEmpty?
              Center(
                child: Text(
                    'You don''t have any groups',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                    fontSize: 23,
                    fontFamily: 'comfortaa'
                  ),
                ),
              ):
              ListView.builder(
                itemCount: docs.length,
                  itemBuilder: (ctx, index){
                    return Container(
                      padding: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 20,
                      ),
                      child: GroupCard(
                          _funFun.getColor(docs[index]['color']),
                          docs[index]['image_url'],
                          docs[index].id,
                          docs[index]['interest'],
                          docs[index]['number'],
                          docs[index]['owner'] == FirebaseAuth.instance.currentUser?.uid,
                          docs[index]['date']

                      ),
                    );
                  }
              )
          )
      ),
    );

  }


}
