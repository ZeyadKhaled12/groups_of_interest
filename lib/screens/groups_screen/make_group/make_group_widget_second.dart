import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaito/functions/make_group_fun.dart';
import 'package:kaito/screens/groups_screen/make_group/make_group_widget_third.dart';



class MakeGroupWidgetSecond extends StatefulWidget {
  final String _titleGroup;
  final String _interest;

  MakeGroupWidgetSecond(this._titleGroup, this._interest);

  @override
  _MakeGroupWidgetSecondState createState() => _MakeGroupWidgetSecondState();
}

class _MakeGroupWidgetSecondState extends State<MakeGroupWidgetSecond> {

  MakeGroupFun _makeGroupFun = new MakeGroupFun();


  bool _isLoading = false;


  Widget container() {
    return Container(
      child:
      _isLoading?
        Center(
          child:
          CircularProgressIndicator(strokeWidth: 2.5,valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)),
        ):
      _image.path == 'text'
          ? Text('',)
          : Image.file(
        _image,
        fit: BoxFit.cover,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: _isLoading?
        Colors.grey.withOpacity(0):
        Colors.grey.withOpacity(0.5),
      ),
      width: 340,
      height: 200,
    );
  }

  late var _image = File('text');
  final picker = ImagePicker();

  Future getImage(ImageSource src) async {

    final pickedFile = await picker.pickImage(
        source: src,
        maxWidth: 340,
        imageQuality: 60
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    return pickedFile?.path;
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.yellowAccent,
        fontSize: 19,
        fontFamily: 'comfortaa',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget rowOfDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.circle,
          color: Colors.yellowAccent.withOpacity(0.5),
        ),
        Icon(
          Icons.circle,
          color: Colors.yellowAccent,
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget._titleGroup);
    print(widget._interest);
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
                color: Theme.of(context).primaryColor.withOpacity(0.5),
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
                    Padding(padding: EdgeInsets.only(bottom: 90)),

                    Text(
                      'Making Group',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 41,
                        fontFamily: 'comfortaa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(bottom: 53)),
                    text('Pick picture for your group'),


                    Padding(padding: EdgeInsets.only(bottom: 5)),

                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: container()),

                    Padding(padding: EdgeInsets.only(bottom: 3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: IconButton(
                            highlightColor: Colors.white,
                            icon: Icon(
                              Icons.camera_alt,
                              size: 48,
                              color: Colors.yellowAccent.withOpacity(0.8),
                            ),
                            onPressed: () async {

                              await getImage(ImageSource.camera).then((value) async{
                                await ImageCropper.cropImage(
                                    sourcePath: value,
                                    aspectRatio: CropAspectRatio(
                                        ratioX: 340, ratioY: 200),
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square
                                    ],
                                    androidUiSettings: AndroidUiSettings(
                                      initAspectRatio:
                                      CropAspectRatioPreset.original,
                                      lockAspectRatio: false,
                                      cropFrameColor: Colors.yellowAccent,
                                      toolbarColor: Colors.yellowAccent,
                                      activeControlsWidgetColor:
                                      Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                    )).then((value) {
                                  setState(() {
                                    _image = File('${value?.path}');
                                  });
                                });
                              });
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(20)),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: IconButton(
                            highlightColor: Colors.white,
                            icon: Icon(
                              Icons.photo,
                              size: 48,
                              color: Colors.yellowAccent.withOpacity(0.8),
                            ),
                            onPressed: () async {
                              await getImage(ImageSource.gallery).then((value) async{
                                await ImageCropper.cropImage(
                                    sourcePath: value,
                                    aspectRatio: CropAspectRatio(
                                        ratioX: 340, ratioY: 200),
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square
                                    ],
                                    androidUiSettings: AndroidUiSettings(
                                      initAspectRatio:
                                      CropAspectRatioPreset.original,
                                      lockAspectRatio: false,
                                      cropFrameColor: Colors.yellowAccent,
                                      toolbarColor: Colors.yellowAccent,
                                      activeControlsWidgetColor:
                                      Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                    )).then((value) {
                                  setState(() {
                                    _image = File('${value?.path}');
                                  });
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),

                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.yellowAccent.withOpacity(0.6),
                                size: 48,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: IconButton(



                              onPressed: () async {
                                if( _image.path != 'text'){

                                setState(() {
                                  _isLoading = true;
                                });
                                print('\n\n\n\n\n\n\n\nWE ARE HERE\n\n\n\n\n\n\n\n\n');
                                String url = await _makeGroupFun.uploadImage(context, _image, widget._titleGroup, widget._interest);
                                setState(() {
                                  _isLoading = false;
                                });
                                await Navigator.pushReplacement(
                                    context, MaterialPageRoute(
                                        builder: (_) => MakeGroupWidgetThird(url, widget._titleGroup, widget._interest)));
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.yellowAccent.withOpacity(0.6),
                                size: 48,
                              )),



                        )
                      ],
                    ),
                    rowOfDots(),
                    Padding(padding: EdgeInsets.only(top: 30)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
