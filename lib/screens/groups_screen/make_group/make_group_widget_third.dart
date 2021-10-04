import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/functions/make_group_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/groups_screen/make_group/make_group.dart';
import 'package:provider/provider.dart';



class MakeGroupWidgetThird extends StatefulWidget {


  final String url;
  final String titleGroup;
  final String interest;
  MakeGroupWidgetThird(this.url, this.titleGroup, this.interest);

  @override
  _MakeGroupWidgetThirdState createState() => _MakeGroupWidgetThirdState();
}

class _MakeGroupWidgetThirdState extends State<MakeGroupWidgetThird> {

  Color? _color;

  /*
  bool _isClick1 = false;
  bool _isClick2 = false;
  bool _isClick3 = false;
  bool _isClick4 = false;
  bool _isClick5 = false;
  bool _isClick6 = false;
  bool _isClick7 = false;
  bool _isClick8 = false;
   */

  MakeGroupFun _makeGroupFun = new MakeGroupFun();


  Widget colorIcon(Color color){
    return
       InkWell(
         onTap: (){
           setState(() {
             if(color != Colors.white){
               _color = color;
             }
             else{
               _color = Colors.white.withOpacity(0);
             }

           });
         },
        child: CircleAvatar(
          backgroundColor: color == Colors.white? color.withOpacity(0.25):color.withOpacity(0.5),
          radius: 40,
          child: CircleAvatar(
            backgroundColor: color == Colors.white? color.withOpacity(0.25):color.withOpacity(0.5),
            radius: 36,
          ),
        ),
      );

  }

  Widget details(String string, Color color){
    return Text(
      string,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'comfortaa',
      ),
    );
  }

  Widget expansionTile(){

    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                topLeft: Radius.circular(100)
            )
        ),

        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            details('${widget.titleGroup}', Colors.yellowAccent.withOpacity(0.8)),
            Padding(padding: EdgeInsets.only(bottom: 30)),

            details('${widget.interest}', Colors.yellowAccent.withOpacity(0.8)),
            Padding(padding: EdgeInsets.only(bottom: 30)),

            details('0 online now', Colors.yellowAccent.withOpacity(0.8)),
            Padding(padding: EdgeInsets.only(bottom: 10)),

          ],
        ),
      ),
    );

  }




  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/chatImage.jpg'),
            ),
            borderRadius: BorderRadius.circular(30)),

        child: Stack(


          alignment: Alignment.topCenter,
          children: <Widget>[

            Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),

            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0),
                      Theme.of(context).primaryColor,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                  )),
            ),

            SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(padding: EdgeInsets.only(bottom: 40)),
                  Text(
                    'Pick color to your picture',
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 25,
                      fontFamily: 'comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 23)),


                  Container(
                    width: 340,
                    height: 200,
                    decoration: BoxDecoration(
                      //color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.url)
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[

                        Opacity(
                          opacity: 0.3,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black, borderRadius: BorderRadius.circular(30)),
                          ),
                        ),

                        Opacity(
                          opacity: 0.3,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: _color, borderRadius: BorderRadius.circular(30)),
                          ),
                        ),


                        Center(
                          child: Text(
                            '${widget.titleGroup}',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellowAccent,
                                fontFamily: 'comfortaa'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: TextButton(
                                onPressed: () async{
                                  await showModalBottomSheet(
                                    //isScrollControlled: true,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) => expansionTile());
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.yellowAccent.withOpacity(0.4))),
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  color: Colors.black,
                                  size: 50,
                                ))),
                      ],
                    )

                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        colorIcon(Colors.red),
                        colorIcon(Colors.orange),
                        colorIcon(Colors.blue),
                        colorIcon(Colors.purple),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        colorIcon(Colors.pinkAccent),
                        colorIcon(Colors.green),
                        colorIcon(Colors.brown),
                        colorIcon(Colors.cyanAccent),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        colorIcon(Colors.deepOrangeAccent),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: FlatButton(
                              highlightColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  )
                              ),
                              color: Colors.yellowAccent.withOpacity(0.3),
                              onPressed: () async{
                                String color = _makeGroupFun.getColor(_color);
                                await _makeGroupFun.setColor(context, widget.titleGroup, color);
                                await Provider.of<UserDetails>(context, listen: false).getYourGroups();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Go',
                                style: TextStyle(
                                    color: Colors.yellowAccent,

                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'comfortaa'
                                ),
                              )),
                        ),
                        colorIcon(Colors.white),
                      ],
                    ),
                  )


                ],
              ),

            )

          ],

        ),



      ),

    );

  }
}
