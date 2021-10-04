import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/groups_screen/group_card.dart';
import 'package:provider/provider.dart';
import 'make_group/make_group.dart';
import 'package:kaito/screens/groups_screen/group_chat/group_chat_screen.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {

  FunFun _funFun = new FunFun();

  var docs;

  Future _refresh() async{
    if(!Provider.of<UserDetails>(context, listen: false).searchSit) {
      await Provider.of<UserDetails>(context, listen: false).getGroups();
    }
    else{
      String searchWord = Provider.of<UserDetails>(context, listen: false).searchWord;
      Provider.of<UserDetails>(context, listen: false).searchForGroups(searchWord);
    }
    setState(() {
      docs = Provider.of<UserDetails>(context, listen: false).groupOfScreen;
    });
  }

  /*
  void startFun() {
    Provider.of<UserDetails>(context, listen: false).nullGroupEnteredFun();
  }





  List list = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.pinkAccent,
    Colors.green,
    Colors.brown,
    Colors.cyanAccent,
    Colors.deepOrangeAccent,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.pinkAccent,
    Colors.green,
    Colors.brown,
    Colors.cyanAccent,
    Colors.deepOrangeAccent,
    Colors.white,
  ];

  List listString = [
    'assets/images/chatImage.jpg',
    'assets/images/invitePic.jpg',
    'assets/images/kaitoPic.jpg',
    'assets/images/signInPic.jpg',
    'assets/images/signUpPic.jpg',
    'assets/images/chatImage.jpg',
    'assets/images/invitePic.jpg',
    'assets/images/kaitoPic.jpg',
    'assets/images/signInPic.jpg',
    'assets/images/signUpPic.jpg'
  ];

  List listInterest = [
    'Music',
    'Congratulation',
    'Programming',
    'Games',
    'Eating',
    'Anime',
    'Animation',
    'League  of legends',
    'Princses',
    'Plyardo'
  ];

  List listTitle = [
    'afdcgfhjf',
    'Worldwide Wolfpack',
    'Connect the Dots',
    'Cousins Across the Pond',
    'Across Borders',
    'Brotherly Harmony',
    'Without Borders',
    'Quality Screen Time',
    'On the Wire',
    'Strong Signals'
  ];

  List listMembers = [
    2334,
    343434644546,
    123,
    343,
    234,
    123,
    124,
    353,
    2344,
    5
  ];





  Widget expansionTile(){

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[],
      ),
    );

  }



  Widget card(Color color, String string, String title) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(string),
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Opacity(
            opacity: 0.2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
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
              height: 30,
              child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => expansionTile()
                    );
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ))),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.yellowAccent.withOpacity(0.3))),
                  child: Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                  ))

              ExpansionTile(
                  collapsedBackgroundColor: Colors.yellowAccent.withOpacity(0.2),
                  collapsedIconColor: Colors.white,

                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                  title: Text(''),
                  onExpansionChanged: (bool){},
                  children: <Widget>[
                    Text('')
                  ]
              )


              )
        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      startFun();
    });


  }

   */



  @override
  Widget build(BuildContext context) {

    docs = Provider.of<UserDetails>(context, listen: true).groupOfScreen;
    return Scaffold(

      /*
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


       */
      body: Container(

          width: double.infinity,

          color: Theme.of(context).primaryColor,

          child: Stack(
            alignment: Alignment.topCenter,
            children: [



              //groups

              /*
              Container(
                padding: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot>(

                  stream: FirebaseFirestore.instance.collection('groups')
                      .orderBy('number',  descending: true)
                      .snapshots(),

                  builder: (ctx, snapShot){
                    if(snapShot.connectionState == ConnectionState.waiting){
                      return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
                    }

                    final docs = snapShot.data!.docs;
                    return GridView.builder(
                        itemCount: docs.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 3 / 2,
                        ),
                        itemBuilder: (ctx, index) {
                          Color color =  _funFun.getColor(docs[index]['color']);
                          String imageUrl = docs[index]['image_url'];
                          String id = docs[index].id;
                          String interest = docs[index]['interest'];
                          int number = docs[index]['number'];
                          bool isOwner = docs[index]['owner'] == FirebaseAuth.instance.currentUser?.uid;
                          Timestamp date = docs[index]['date'];
                          return Container(
                            padding: EdgeInsets.only(
                              right: 20,
                              left: 20,
                              top: 20,
                            ),
                            child: GroupCard(
                                color, imageUrl, id, interest,
                                number, isOwner, date
                            ),
                          );
                        });
                  },
                ),
              ),

               */




              Container(
                padding: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: RefreshIndicator(
                  color:  Colors.yellowAccent,
                  backgroundColor:Theme.of(context).primaryColor,
                  onRefresh: _refresh,
                  child: GridView.builder(
                      itemCount: Provider.of<UserDetails>(context, listen: false).groupOfScreen.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (ctx, index) {

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
                      }),
                )
              ),





              //fav groups
              Container(
                //width: double.infinity,
                height: 63,
                decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.13),

                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)
                    )
                ),

                child:Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 6),
                  child: StreamBuilder<QuerySnapshot>(
                    
                    stream: FirebaseFirestore.instance.collection('favGroup')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('groups').snapshots(),
                    
                    builder: (ctx, snapShot){
                      if(snapShot.connectionState == ConnectionState.waiting){
                        return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
                      }

                      final docs = snapShot.data!.docs;

                      if(docs.isEmpty){
                        return Center(
                          child: Text(
                            'Your favourite groups',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent.withOpacity(0.3),
                              fontFamily: 'comfortaa'
                            ),
                          ),
                        );
                      }

                      return  ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: docs.length,
                          itemBuilder: (ctx, index) {
                            return Opacity(
                              opacity: 0.8,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 0, right: 0),
                                  child: FutureBuilder<List>(
                                    
                                    future: FirebaseFirestore.instance.collection('groups').doc(docs[index].id)
                                    .get().then((value)  {
                                      return [docs[index].id, value.get('interest'), value.get('image_url'), value.get('owner'), value.get('date'), value.get('color')];
                                    }),
                                    
                                    builder: (ctx, snapShot){
                                      if(snapShot.connectionState == ConnectionState.waiting){
                                        return  CircleAvatar(
                                          radius: 28,
                                          backgroundColor: Colors.white.withOpacity(0.8)
                                          ,
                                        );
                                      }
                                      
                                      return InkWell(
                                        onTap: () async{

                                          await Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (_) => GroupChatScreen(snapShot.data?[0], snapShot.data?[1], snapShot.data?[2], snapShot.data?[3] == FirebaseAuth.instance.currentUser?.uid, snapShot.data?[4], _funFun.getColor(snapShot.data?[5]))));

                                        },
                                        child: CircleAvatar(
                                          child: Text(
                                              snapShot.data?[0],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontFamily: 'comfortaa',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                              )),
                                          radius: 28,
                                          backgroundImage: NetworkImage(
                                              '${snapShot.data?[2]}'
                                          )
                                          ,
                                        ),
                                      );
                                    },
                                  )),
                            );
                          });

                    },
                  ),
                ),

              ),

            ],
          )),
    );
  }
}
