import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/screens/groups_screen/group_card.dart';



class YourGScreen extends StatefulWidget {

  @override
  _YourGScreenState createState() => _YourGScreenState();

}

class _YourGScreenState extends State<YourGScreen> {

  FunFun _funFun = new FunFun();
  Future _refresh() async{
    setState(() {});
  }
  Timestamp d= Timestamp.now();



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
          padding: EdgeInsets.only(top: 20),
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: RefreshIndicator(
            color:  Colors.yellowAccent,
            backgroundColor:Theme.of(context).primaryColor,
            onRefresh: _refresh,
            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance.collection('owngroups')
              .doc(FirebaseAuth.instance.currentUser?.uid).collection('groups').
              snapshots(),


              builder: (ctx, snapShot){
                if(snapShot.connectionState == ConnectionState.waiting){
                  return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
                }
                final docs = snapShot.data!.docs;

                if(docs.isEmpty){
                  return Center(
                    child: Text('You don\'t have any groups.',
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'french'
                      ),
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (ctx, index) {

                      return FutureBuilder<List>(

                        future: FirebaseFirestore.instance.collection('groups')
                          .doc(docs[index].id).get().then((value) {
                            return [
                              _funFun.getColor(value.get('color')),
                              value.get('image_url'),
                              docs[index].id,
                              value.get('interest'),
                              value.get('number'),
                              value.get('owner') == FirebaseAuth.instance.currentUser?.uid,
                              value.get('date')
                            ];
                        })
                          ,
                          builder:(ctx, snapShot){
                            if(snapShot.connectionState == ConnectionState.waiting){

                              return
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                child: Container(
                                  width: 340,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      'Waiting',
                                      style: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'comfortaa',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            return  Container(
                              padding: EdgeInsets.only(
                                right: 20,
                                left: 20,
                                top: 20,
                              ),
                              child: GroupCard(

                                snapShot.data?[0],
                                snapShot.data?[1],
                                snapShot.data?[2],
                                snapShot.data?[3],
                                snapShot.data?[4],
                                snapShot.data?[5],
                                snapShot.data?[6],


                                /*
                                  _funFun.getColor(docs[index]['color']),
                                  docs[index]['image_url'],
                                  docs[index].id,
                                  docs[index]['interest'],
                                  docs[index]['number'],
                                  docs[index]['owner'] == FirebaseAuth.instance.currentUser?.uid,
                                  docs[index]['date']

                                 */

                              ),
                            );
                          }

                      );
                    });
              },
            )
          )
      ),
    );

  }

}
