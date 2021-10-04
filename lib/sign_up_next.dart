import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/sign_up_next_next.dart';
import 'package:provider/provider.dart';






class SignUpNext extends StatefulWidget {
  @override
  _SignUpNextState createState() => _SignUpNextState();
}

class _SignUpNextState extends State<SignUpNext> {


  Future makeFalse() async{
    await Provider.of<UserDetails>(context, listen: false).getLoginCode();
    await Provider.of<UserDetails>(context, listen: false).getEmail();
    await FirebaseFirestore.instance
        .collection('codes')
        .doc(Provider.of<UserDetails>(context, listen: false).loginCode)
        .update({'firstTime': 'false'});
  }


  @override

  initState(){
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    makeFalse();
  }





  Widget button(Color color, String colors){
    return SizedBox(
      width: 110,
      height: 100,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        highlightColor: Colors.white,
        color: color,
          onPressed: () async{
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => SignUpNextNext(
                Provider.of<UserDetails>(context, listen: false).email,
                Provider.of<UserDetails>(context, listen: false).loginCode
            )));
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
            'color': colors
          });

          },
          child:  Text('')
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        /*
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.yellowAccent,
                Theme.of(context).primaryColor
              ],
            ),
          ),

         */

        color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.all(28)),
              Text(
                  'Pick color to your picture',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'french'
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 button(Colors.red, 'red'),
                 Padding(padding: EdgeInsets.only(right: 6)),
                 button(Colors.orange, 'orange'),
                 Padding(padding: EdgeInsets.only(right: 6)),
                 button(Colors.blue, 'blue'),
               ],
             ),
              Padding(padding: EdgeInsets.only(bottom: 6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  button(Colors.purple, 'purple'),
                  Padding(padding: EdgeInsets.only(right: 6)),
                  button(Colors.pinkAccent, 'pink'),
                  Padding(padding: EdgeInsets.only(right: 6)),
                  button(Colors.green, 'green'),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  button(Colors.brown, 'brown'),
                  Padding(padding: EdgeInsets.only(right: 6)),
                  button(Colors.cyanAccent, 'cyan'),
                  Padding(padding: EdgeInsets.only(right: 6)),
                  button(Colors.deepOrangeAccent, 'deepOrange'),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: 100,
                height: 100,
                child: FlatButton(
                  highlightColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => SignUpNextNext(
                        Provider.of<UserDetails>(context, listen: false).email,
                        Provider.of<UserDetails>(context, listen: false).loginCode
                    )));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  color: Colors.yellowAccent,
                  child: Icon(
                    Icons.arrow_right,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(3)),
              Text('Skip',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.bold,
                  )),
             Padding(padding: EdgeInsets.all(10)),


            ],
          )
      ),
    );
  }
}
