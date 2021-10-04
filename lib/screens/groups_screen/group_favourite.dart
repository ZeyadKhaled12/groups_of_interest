import 'package:flutter/material.dart';



class GroupFavourite extends StatefulWidget {

  bool _isScroll;
  GroupFavourite(this._isScroll);


  @override
  _GroupFavouriteState createState() => _GroupFavouriteState();

}

class _GroupFavouriteState extends State<GroupFavourite> {


  late bool _isScroll;



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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget._isScroll){

      _isScroll = true;

    }

    else{

      _isScroll = false;

    }
  }

  @override
  Widget build(BuildContext context) {

    return
    _isScroll?
    Flexible(
      flex: 0,
      child:
     Text(''),
    ):
    Flexible(
      flex: 1,
      child:

      Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40)
            )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Flexible(
              child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 18,
                  itemBuilder: (ctx, index) {
                    return Opacity(
                      opacity: 1,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 3, right: 3),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white.withOpacity(0.4),
                            child: CircleAvatar(
                                radius: 28,
                                //backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/kaito-793d3.appspot.com/o/group_image%2Fsaba7.jpg?alt=media&token=01f4efbd-8664-4ee7-9d6d-814acee64667'),
                                backgroundColor: list[index]
                            ),
                          )),
                    );
                  }),
            ),

            /*
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30)
                            )
                          ),
                          color: Colors.yellowAccent.withOpacity(0.2),
                            onPressed: (){},
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.yellowAccent,
                            )),
                      )
                       */
          ],
        ),
      ),
    );

  }


}
