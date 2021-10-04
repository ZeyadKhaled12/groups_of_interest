import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/screens/groups_screen/make_group/make_group_widget_second.dart';




class MakeGroupWidgetFirst extends StatefulWidget {



  @override
  _MakeGroupWidgetFirstState createState() => _MakeGroupWidgetFirstState();
}

class _MakeGroupWidgetFirstState extends State<MakeGroupWidgetFirst> {

  TextEditingController _titleGroup = TextEditingController();
  TextEditingController _interestGroup = TextEditingController();
  FunFun _funFun = new FunFun();
  bool _isLoading = false;





  Future dialog(String msg, double size,){

    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // <-- Radius
        ),
        backgroundColor: Colors.yellowAccent,
        title: Text(msg,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: size,
                fontWeight: FontWeight.bold
            )),
        content:
        Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Divider(
                thickness: 2.5,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 7,
              ),

              SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child:  FlatButton(
                          highlightColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () async{
                            Navigator.pop(context);
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text('Ok', style:
                          TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          )),
                        ),
                      ),
                    ],
                  )
              )

            ],
          ),
        )

    );

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Opacity(child: alert , opacity: 0.699999);
        });
  }


  Widget txtField(TextEditingController  _controller , List<TextInputFormatter> list){
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30,),
      child:  Container(
        decoration: BoxDecoration(
          color: Colors.yellowAccent.withOpacity(0.28),
          borderRadius:  BorderRadius.circular(25),
        ),
        child: TextField(
          inputFormatters: list,
          maxLength: 15,
          controller: _controller,
          cursorColor: Colors.yellowAccent,
          style: TextStyle(
            fontSize: 25,
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontFamily: 'comfortaa',
          ),
          decoration: InputDecoration(
            counterText: '',
            //suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  Widget text(String text){
    return Text(
      text,
      style: TextStyle(
        color: Colors.yellowAccent,
        fontSize: 28,
        fontFamily: 'comfortaa',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget rowOfDots(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.circle,
          color: Colors.yellowAccent,
        ),
        Icon(
          Icons.circle,
          color: Colors.yellowAccent.withOpacity(0.5),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 90)),
          Text(
            'Making Group',
            style: TextStyle(
              color: Colors.yellowAccent,
              fontSize: 41,
              fontFamily: 'comfortaa',
              fontWeight: FontWeight.bold,),
          ),
          Padding(padding: EdgeInsets.only(bottom: 60)),
          text('Title of group'),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          txtField(_titleGroup, []),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          text('Interest'),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          txtField(_interestGroup, [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))]),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          Padding(
            child:
            _isLoading?
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)):
            SizedBox(
              height: 80,
              width: 120,
              child: FlatButton(
                  highlightColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      )
                  ),
                  color: Colors.yellowAccent.withOpacity(0.3),
                  onPressed: () async{
                    if(_funFun.isTyping(_titleGroup.text) && _interestGroup.text != '') {
                      setState(() {
                        _isLoading = true;
                      });
                      bool isExist = await FirebaseFirestore.instance
                          .collection('groups').doc(_titleGroup.text)
                          .get().then((value) {
                        return value.exists;
                      });
                      if (!isExist) {
                        String msg = _funFun.string;
                        await Navigator.push(
                            context, MaterialPageRoute(
                            builder: (_) =>
                                MakeGroupWidgetSecond(
                                    msg, _interestGroup.text)));
                      }
                      else{
                        setState(() {
                          _isLoading = false;
                        });
                        return dialog('Title already in use.', 20);
                      }
                      setState(() {
                        _isLoading = false;
                      });

                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.yellowAccent,

                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'comfortaa'
                    ),
                  )),
            ),
            padding: EdgeInsets.only(left: 30, right: 30),
          ),
          Padding(padding: EdgeInsets.only(bottom: 25)),
          rowOfDots(),
          Padding(padding: EdgeInsets.only(top: 30)),

        ],
      ),
    );
  }
}
