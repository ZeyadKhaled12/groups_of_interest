import 'package:flutter/material.dart';
import 'package:kaito/functions/group_setting_fun.dart';
import 'package:kaito/functions/make_group_fun.dart';




class ChangeColorImage extends StatefulWidget {


  final String _titleGroup;
  final Color _color;
  final String _imageUrl;
  ChangeColorImage(this._titleGroup, this._color, this._imageUrl);

  @override
  _ChangeColorImageState createState() => _ChangeColorImageState();


}

class _ChangeColorImageState extends State<ChangeColorImage> {

  Color? _color;
  bool _isFirst = false;
  bool _isLoading = false;
  MakeGroupFun _makeGroupFun = new MakeGroupFun();
  GroupSettingFun _groupSettingFun = new GroupSettingFun();

  Widget colorIcon(Color color){
    return
      Padding(
        padding: EdgeInsets.only(left: 11),
        child: InkWell(
          onTap: (){
            setState(() {
              _isFirst = true;
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
            radius: 25,
            child: CircleAvatar(
              backgroundColor: color == Colors.white? color.withOpacity(0.25):color.withOpacity(0.5),
              radius: 21,
            ),
          ),
        ),
      );

  }

  Widget container (){
    return Container(
        width: 340,
        height: 200,
        decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget._imageUrl)
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
                    color: _isFirst? _color: widget._color == Colors.white?widget._color.withOpacity(0):widget._color, borderRadius: BorderRadius.circular(30)),
              ),
            ),


            _isLoading?
            Center(
              child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent))
            ):
            Center(
              child: Text(
                '${widget._titleGroup}',
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
                      setState(() {
                        _isFirst = false;
                      });
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ))),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.yellowAccent.withOpacity(0.4))),
                    child: Text('Back to the previous color', style:
                        TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )))),
          ],
        )

    );

  }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        container(),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              colorIcon(Colors.red),
              colorIcon(Colors.orange),
              colorIcon(Colors.blue),
              colorIcon(Colors.purple),
              colorIcon(Colors.pinkAccent),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              colorIcon(Colors.green),
              colorIcon(Colors.brown),
              colorIcon(Colors.cyanAccent),
              colorIcon(Colors.deepOrangeAccent),
              colorIcon(Colors.white),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 3)),
        SizedBox(
          width: 340,
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              color: Colors.yellowAccent.withOpacity(0.8),
              onPressed:() async{
                if(_color != widget._color && _isFirst) {
                  setState(() {
                    _isLoading = true;
                  });
                  print('CLICKED');
                  await _groupSettingFun.changeColor(
                      widget._titleGroup, _makeGroupFun.getColor(_color));
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Submit',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'comfortaa'))),
        )
      ],
    );

  }


}
