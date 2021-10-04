import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaito/main.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';





class AppBarHomeScreen extends StatefulWidget {

  @override
  _AppBarHomeScreenState createState() => _AppBarHomeScreenState();

}

class _AppBarHomeScreenState extends State<AppBarHomeScreen> {


  bool _isSearch = true;
  TextEditingController _controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return SliverAppBar(

      pinned: true,
      floating: true,
      snap: true,


      title:
      _isSearch == false?


      Text(''):

      Text('Kaito', style: TextStyle(
          fontFamily: 'comfortaa',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyText1?.color)),


      actions: [

        _isSearch == false?

        /*
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              //highlightColor: Colors.yellowAccent,

              onPressed: () async{setState(() {
                _isSearch = !_isSearch;
              });},

              iconSize: 30,

              icon: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            )
        ):
        */


        Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 60, top: 10, bottom: 10, right: 10),
              child:  Container(
                width: double.infinity,
                height:  double.infinity,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    borderRadius: BorderRadius.all(
                        Radius.circular(30))),
                //width: double.infinity,
                child: TextField(
                  controller: _controller,

                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
                  onChanged: (value) async{
                    if(value.isEmpty){
                      Provider.of<UserDetails>(context, listen: false).searchSitFun();
                      await Provider.of<UserDetails>(context, listen: false).getGroups();
                    }
                  },

                  onSubmitted: (value) async{
                    if(value.isNotEmpty) {
                      print(value);
                      await Provider.of<UserDetails>(context, listen: false)
                          .searchForGroups(value);
                    }
                  },
                  cursorColor: Theme.of(context).primaryColor.withOpacity(0.8),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(

                      //contentPadding: EdgeInsets.only(bottom: 5),

                    suffixIcon:IconButton(
                      onPressed: () async{
                        setState(() {
                          _isSearch = true;
                        });

                        Provider.of<UserDetails>(context, listen: false).searchSitFun();
                        await Provider.of<UserDetails>(context, listen: false).getGroups();


                        _controller.clear();
                      },
                      icon: Icon(Icons.clear, size: 25,
                          color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    ),





                    border: InputBorder.none,

                    hintText: 'Search for your interests',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ):
        IconButton(onPressed: (){
          setState(() {
            _isSearch = false;
          });
          },
            icon: Icon(Icons.search, size: 25,
                color: Theme.of(context).textTheme.bodyText1?.color))




      ],

      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      bottom: TabBar(
        isScrollable: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 6.0),
        unselectedLabelColor:
        Theme.of(context).textTheme.bodyText1?.color,
        labelColor: Colors.yellowAccent,
        indicatorColor: Colors.yellowAccent,
        indicatorWeight: 1,
        tabs: <Widget>[
          Tab(
            text: 'Groups',
          ),
          Tab(
            text: 'My groups',
          ),
          

        ],
      ),
    );

  }

}
