import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/auth_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/home_screen.dart';
import 'package:kaito/sign_up_next.dart';
import 'package:provider/provider.dart';

import 'functions/drawr_fun.dart';



class SignUpNextNext extends StatefulWidget {

  final String email;
  final String pass;
  final Key? key;

  SignUpNextNext(this.email, this.pass, {this.key});

  @override
  _SignUpNextNextState createState() => _SignUpNextNextState();
}

class _SignUpNextNextState extends State<SignUpNextNext> {


  TextEditingController  _newName = new TextEditingController();
  DrawerFunc _drawerFunc = new DrawerFunc();
  bool _isLoading = false;
  AuthFunc _authFunc = new AuthFunc();


    navigator(int index){
    if(index == 1) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SignUpNext()));
      });

    }
    else{
      Future.delayed(Duration.zero, () async{
        setState(() {
          _isLoading = !_isLoading;
        });
        //await Provider.of<UserDetails>(context, listen: false).isFirstTime(widget.pass);

        await FirebaseAuth.instance.signOut();
        print('SIGN OUT');
        print(widget.email);
        print(widget.pass);



      });
    }
  }


  Widget column(Icon icon , String string, int index){

    return Column(
      children: <Widget>[
        SizedBox(
          width: 100,
          height: 100,
          child: FlatButton(
            highlightColor: Colors.white,
            onPressed: () => navigator(index),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            color: Colors.yellowAccent,
            child:icon
          ),
        ),

        Padding(padding: EdgeInsets.all(3)),
        Text(string,
            style: TextStyle(
              fontSize: 20,
              color: Colors.yellowAccent,
              fontWeight: FontWeight.bold,
            )),
      ],
    );

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(
        height: double.infinity,

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

        child: _isLoading?
        Center(child:SizedBox( height:50,width: 50 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent), strokeWidth: 6,)),) :
        SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,

            children: <Widget>[
              Padding(padding: EdgeInsets.all(74)),

              Text(
                'Write your username',
                style: TextStyle(
                    fontSize: 29,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.bold,
                ),
              ),

              Padding(padding: EdgeInsets.all(10)),

              SizedBox(
                width: 300,
                child: TextField(

                  controller: _newName,
                  maxLength: 15,
                  maxLengthEnforced: true,
                  style: TextStyle(
                      fontSize: 20,
                      color:  Colors.yellowAccent,
                      fontWeight: FontWeight.bold
                  ),

                  decoration: InputDecoration(
                    filled: true,
                    hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Type your new username",
                    fillColor: Colors.yellowAccent.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),


              SizedBox(
                width: 300,
                child: FlatButton(

                  highlightColor: Colors.yellowAccent,
                  onPressed: () async{
                    setState(() {
                      _isLoading = !_isLoading;
                    });
                    if(_newName.text.contains(new RegExp(r'[A-Z]')) || _newName.text.contains(new RegExp(r'[a-z]')) ||  _newName.text.contains(new RegExp(r'[أ-ي]'))){
                      await _drawerFunc.changeUserName(_newName.text,context);

                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => HomeScreen()));
                    }
                    setState(() {
                      _isLoading = !_isLoading;
                    });
                  },
                  color: Colors.yellowAccent.withOpacity(0.4),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),


              Padding(padding: EdgeInsets.all(50)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  column(Icon(Icons.arrow_left, size: 80, color: Theme.of(context).primaryColor), 'Back', 1),
                  Padding(padding: EdgeInsets.all(50)),
                  column(Icon(Icons.arrow_right, size: 80, color: Theme.of(context).primaryColor), 'Skip', 2),
                ],
              ),

              //Padding(padding: EdgeInsets.all(32)),

            ],

          ),
        ),

      ),

    );


  }
}
